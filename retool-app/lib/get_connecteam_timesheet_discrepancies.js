//  await Connecteam_Timesheet_Totals.trigger();
//  await Connecteam_Shifts.trigger();
const timesheetData = await Connecteam_Timesheet_Totals.trigger();  // Timesheet Totals API response
const shiftsData = await Connecteam_Shifts.trigger();              // Shifts API response

const TZ = "America/New_York";
const IGNORED_USER_IDS = new Set([
  // user IDs excluded from discrepancy checks (removed for this public copy)
]);

const IGNORED_JOB_TITLES = new Set([
  'Captain meeting',
  'training',
  'Training',
  'training instructor',
  'DOT medical',
  'DOT testing',
  'captain training'
]);
// Helper: convert epoch seconds → YYYY-MM-DD in the given timezone
const epochToDate = (epochSec) => {
  if (!epochSec) return null;
  const d = new Date(epochSec * 1000);
  // en-CA gives YYYY-MM-DD format
  return d.toLocaleDateString("en-CA", { timeZone: TZ });
};

// ---- Build sets from each source ----

// Shifts API → set of "userId|date" keys + map of empty-shiftLayer shifts
const shiftPairs = new Set();
const emptyLayerShifts = [];

(shiftsData?.data?.shifts || []).forEach((s) => {
  const date = epochToDate(s.startTime);
  const layers = s?.shiftDetails?.shiftLayers || [];
  const isEmpty = layers.length === 0 && !IGNORED_JOB_TITLES.has(s.title);

  (s.assignedUserIds || []).forEach((uid) => {
    shiftPairs.add(`${uid}|${date}`);
    if (isEmpty) {
      emptyLayerShifts.push({
        shiftId: s.id,
        userId: uid,
        date: date,
        title: s.title || "",
      });
    }
  });
});

// Timesheet Totals → flat array of one entry per user-day
const timesheetEntries = [];
(timesheetData?.data?.users || []).forEach((u) => {
  (u.dailyRecords || []).forEach((day) => {
    const pay = (day.payItems || []).reduce(
      (sum, p) => sum + (p.totalPay || 0),
      0
    );
    const hasRate = (day.payItems || []).every(
      (p) => p.actualPayRate !== undefined
    );
    timesheetEntries.push({
      userId: u.userId,
      date: day.date,
      hours: day.dailyTotalHours || 0,
      pay: pay,
      hasRate: hasRate,
      key: `${u.userId}|${day.date}`,
    });
  });
});

const timesheetPairs = new Set(timesheetEntries.map((e) => e.key));

// ---- Compute discrepancies ----

// 1. In Timesheets but NOT in Shifts API → unscheduled / missing-from-shifts
const missingFromShifts = timesheetEntries
  .filter((e) => !shiftPairs.has(e.key) && !IGNORED_USER_IDS.has(e.userId))
  .sort((a, b) => a.date.localeCompare(b.date) || a.userId - b.userId);

// 2. In Shifts API but NOT in Timesheets → scheduled but no clock-in
const noTimesheet = [];
shiftPairs.forEach((key) => {
  if (!timesheetPairs.has(key)) {
    const [userId, date] = key.split("|");
    noTimesheet.push({ userId: Number(userId), date });
  }
});
noTimesheet.sort((a, b) => a.date.localeCompare(b.date) || a.userId - b.userId);

// 3. Shifts with empty shiftLayers (script-dropped)
emptyLayerShifts.sort(
  (a, b) => a.date.localeCompare(b.date) || a.userId - b.userId
);

// ---- Totals ----
const totalLaborHours = timesheetEntries.reduce((s, e) => s + e.hours, 0);
const totalLaborPay = timesheetEntries.reduce((s, e) => s + e.pay, 0);
const missingHours = missingFromShifts.reduce((s, e) => s + e.hours, 0);
const missingPay = missingFromShifts.reduce((s, e) => s + e.pay, 0);

return {
  summary: {
    timesheetEntryCount: timesheetEntries.length,
    shiftPairCount: shiftPairs.size,
    totalLaborHours: +totalLaborHours.toFixed(2),
    totalLaborPay: +totalLaborPay.toFixed(2),
    missingFromShiftsCount: missingFromShifts.length,
    missingHours: +missingHours.toFixed(2),
    missingPay: +missingPay.toFixed(2),
    noTimesheetCount: noTimesheet.length,
    emptyLayerShiftCount: emptyLayerShifts.length,
  },
  missingFromShifts,    // timesheet entries with no matching shift
  noTimesheet,          // shifts with no matching timesheet entry
  emptyLayerShifts,     // shifts missing shiftLayers (would be dropped)
};