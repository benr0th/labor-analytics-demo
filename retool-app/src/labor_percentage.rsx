<Screen
  id="labor_percentage"
  _customShortcuts={[]}
  _hashParams={[]}
  _order={0}
  _searchParams={[]}
  browserTitle=""
  title="Labor Percentage"
  urlSlug=""
  uuid="e95945e4-8a02-4516-9377-7c7c2bd99e65"
>
  <Folder id="vars">
    <State id="discrepancies_table" />
    <State id="unmatchedHunkwareIDs" />
    <State
      id="most_recent_labordata_date"
      _comment="Maps all dates from labor data table and returns the max (most recent) date"
      value="{{ new Date(Math.max.apply(null,labor_data.data.map(row => new Date(row.date)))) }}"
    />
    <State id="date_range_start" value="" />
    <State id="date_range_end" value="" />
    <State id="totalMoveLabor" />
    <State id="totalMoveLaborPrevPP" />
    <State id="totalJunkLabor" />
    <State id="totalJunkLaborPrevPP" />
    <State id="totalMoveRev" />
    <State id="totalMoveRevPrevPP" />
    <State id="totalJunkRev" />
    <State id="totalJunkRevPrevPP" />
  </Folder>
  <Folder id="getters">
    <SqlQueryUnified
      id="get_users"
      query={include("../lib/get_users.sql", "string")}
      resourceDisplayName="Supabase - Demo"
      resourceName="b4731250-4b92-46f4-a6f7-45cca5606d79"
      resourceTypeOverride=""
      warningCodes={[]}
    />
    <SqlQueryUnified
      id="get_settings"
      isMultiplayerEdited={false}
      query={include("../lib/get_settings.sql", "string")}
      resourceDisplayName="Supabase - Demo"
      resourceName="b4731250-4b92-46f4-a6f7-45cca5606d79"
      resourceTypeOverride=""
      runWhenModelUpdates={false}
      showSuccessToaster={false}
      warningCodes={[]}
    >
      <Event
        id="04d1bdbf"
        event="success"
        method="setValue"
        params={{
          map: {
            value:
              "{{ self.data.value[self.data.key.findIndex(v => v === 'include_out_of_state')] }}",
          },
        }}
        pluginId="include_out_of_state"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        id="d8528dba"
        event="success"
        method="setValue"
        params={{
          map: {
            value:
              "{{ self.data.value[self.data.key.findIndex(v => v === 'move_labor_goal')] }}",
          },
        }}
        pluginId="move_labor_goal"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        id="d8528dba"
        event="success"
        method="setValue"
        params={{
          map: {
            value:
              "{{ self.data.value[self.data.key.findIndex(v => v === 'junk_labor_goal')] }}",
          },
        }}
        pluginId="junk_labor_goal"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        id="d8528dba"
        event="success"
        method="setValue"
        params={{
          map: {
            value:
              "{{ self.data.value[self.data.key.findIndex(v => v === 'bonus_goal')] }}",
          },
        }}
        pluginId="bonus_goal"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        id="fdf4f775"
        event="success"
        method="setValue"
        params={{
          map: {
            value:
              "{{ self.data.value[self.data.key.findIndex(v => v === 'use_custom_date_range')] }}",
          },
        }}
        pluginId="use_custom_date_range"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        id="9aa8a996"
        event="success"
        method="setValue"
        params={{
          map: {
            value:
              "{{ self.data.value[self.data.key.findIndex(v => v === 'include_utility')] }}",
          },
        }}
        pluginId="include_utility"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        id="9aa8a996"
        event="success"
        method="setValue"
        params={{
          map: {
            value:
              "{{ self.data.value[self.data.key.findIndex(v => v === 'include_commissions')] }}",
          },
        }}
        pluginId="include_commissions"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        id="249fd1f4"
        event="success"
        method="setValue"
        params={{
          map: {
            value:
              "{{ self.data.value[self.data.key.findIndex(v => v === 'all_time_labor_show_move')] }}",
          },
        }}
        pluginId="all_time_labor_show_move"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        id="249fd1f4"
        event="success"
        method="setValue"
        params={{
          map: {
            value:
              "{{ self.data.value[self.data.key.findIndex(v => v === 'all_time_labor_show_junk')] }}",
          },
        }}
        pluginId="all_time_labor_show_junk"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
    </SqlQueryUnified>
    <SqlQueryUnified
      id="get_last_selected_pay_period"
      isMultiplayerEdited={false}
      query={include("../lib/get_last_selected_pay_period.sql", "string")}
      queryDisabled="{{ true }}"
      queryTriggerDelay=""
      resourceDisplayName="Supabase - Demo"
      resourceName="b4731250-4b92-46f4-a6f7-45cca5606d79"
      resourceTypeOverride=""
      runWhenModelUpdates={false}
      runWhenPageLoadsDelay="0"
      showSuccessToaster={false}
      warningCodes={[]}
    >
      <Event
        id="7a6ff98b"
        event="success"
        method="run"
        params={{
          map: {
            src: 'const date_val = self.data.value[0];\n\nconst [startStr, endStr] = date_val.split("-").map(s => s.trim());\n\nawait set_pay_period_to_most_recent.trigger({additionalScope: {start: "4/12/2026"}})\n\nif (use_custom_date_range.value === false) {\n  date_range_start.setValue(moment.utc(startStr, "M/D/YYYY").startOf("day").toISOString());\n\ndate_range_end.setValue(moment.utc(endStr, "M/D/YYYY").endOf("day").toISOString());\n  \n  //  await set_date_filter_stack.trigger({additionalScope: {table: labor_data, column: \'date\', custom_date: false}})\n  //  await set_date_filter_stack.trigger({additionalScope: {table: hunkware_rev, column: \'Job Date\', custom_date: false}})\n\n  await Promise.all([\n    //  getTotalsByDay.trigger(),\n    getTotalLabor.trigger({additionalScope: {in_labor_type: "Move"}}),\n    getTotalLabor.trigger({additionalScope: {in_labor_type: "Junk"}}),\n    getTotalRev.trigger({additionalScope: {job_type1: "Moving", job_type2: "Move Labor"}}),\n    getTotalRev.trigger({additionalScope: {job_type1: "Junk Removal", job_type2: "Labor"}}),\n    set_date_filter_stack.trigger({additionalScope: {table: sales_office_labor, column: \'date\', custom_date: false}}),\n    get_connecteam_timesheet_discrepancies.trigger()\n  ])\n  //  await getTotalsByCaptain.trigger()\n}',
          },
        }}
        pluginId=""
        type="script"
        waitMs="0"
        waitType="debounce"
      />
    </SqlQueryUnified>
    <SqlQueryUnified
      id="get_last_selected_date_range"
      isMultiplayerEdited={false}
      query={include("../lib/get_last_selected_date_range.sql", "string")}
      queryTriggerDelay=""
      resourceDisplayName="Supabase - Demo"
      resourceName="b4731250-4b92-46f4-a6f7-45cca5606d79"
      resourceTypeOverride=""
      runWhenModelUpdates={false}
      showSuccessToaster={false}
      warningCodes={[]}
    >
      <Event
        id="a70cca9f"
        enabled=""
        event="success"
        method="run"
        params={{
          map: {
            src: 'function toStartOfDay(val) {\n  return moment.utc(val, "YYYY-MM-DD").startOf("day").toISOString();\n}\n\nfunction toEndOfDay(val) {\n  return moment.utc(val, "YYYY-MM-DD").endOf("day").toISOString();\n}\n\ncustom_date_range.setStartValue(self.data.value[0].start)\ncustom_date_range.setEndValue(self.data.value[0].end)\n\nif (use_custom_date_range.value) {\n\n  //  const [start, end] = await Promise.all([\n  //    toStartOfDay.trigger({additionalScope: {val: self.data.value[0].start}}),\n  //    toEndOfDay.trigger({additionalScope: {val: self.data.value[0].end}})\n  //  ])\n  const start = toStartOfDay(self.data.value[0].start)\n  const end = toEndOfDay(self.data.value[0].end)\n  date_range_start.setValue(start)\n  date_range_end.setValue(end)\n  await Promise.all([\n    //  getTotalsByDay.trigger(),\n    getTotalLabor.trigger({additionalScope: {in_labor_type: "Move"}}),\n    getTotalLabor.trigger({additionalScope: {in_labor_type: "Junk"}}),\n    getTotalRev.trigger({additionalScope: {job_type1: "Moving", job_type2: "Move Labor"}}),\n    getTotalRev.trigger({additionalScope: {job_type1: "Junk Removal", job_type2: "Labor"}}),\n    set_date_filter_stack.trigger({additionalScope: {table: sales_office_labor, column: \'date\', custom_date: true}}),\n    get_connecteam_timesheet_discrepancies.trigger()\n  ])\n  //  await getTotalsByCaptain.trigger()\n}',
          },
        }}
        pluginId=""
        type="script"
        waitMs="0"
        waitType="debounce"
      />
    </SqlQueryUnified>
  </Folder>
  <Folder id="transformers">
    <Function
      id="get_pay_periods_in_captGraph_daterange"
      funcBody={include(
        "../lib/get_pay_periods_in_captGraph_daterange.js",
        "string"
      )}
    />
    <Function
      id="adj_bonus_threshold"
      funcBody={include("../lib/adj_bonus_threshold.js", "string")}
    />
    <Function
      id="bonus_transformer"
      funcBody={include("../lib/bonus_transformer.js", "string")}
    />
    <Function
      id="bonus_to_captain"
      funcBody={include("../lib/bonus_to_captain.js", "string")}
    />
    <Function
      id="capt_junk_commissions_transformer"
      funcBody={include(
        "../lib/capt_junk_commissions_transformer.js",
        "string"
      )}
    />
    <Function
      id="adj_bonus_total"
      funcBody={include("../lib/adj_bonus_total.js", "string")}
    />
    <Function
      id="graphPayPeriod_values"
      funcBody={include("../lib/graphPayPeriod_values.js", "string")}
    />
    <Function
      id="get_pay_periods_in_OverallGraph_daterange"
      funcBody={include(
        "../lib/get_pay_periods_in_OverallGraph_daterange.js",
        "string"
      )}
    />
    <Function
      id="get_all_pay_periods"
      funcBody={include("../lib/get_all_pay_periods.js", "string")}
    />
    <Function
      id="discrepancies_extra"
      funcBody={include("../lib/discrepancies_extra.js", "string")}
    />
    <Function
      id="discrepancies_table_transformer"
      funcBody={include("../lib/discrepancies_table_transformer.js", "string")}
    />
  </Folder>
  <Folder id="supabase_toggles">
    <SqlQueryUnified
      id="toggle_out_of_state"
      _additionalScope={["toggle_state"]}
      isMultiplayerEdited={false}
      notificationDuration={4.5}
      query={include("../lib/toggle_out_of_state.sql", "string")}
      resourceDisplayName="Supabase"
      resourceName="7a13180c-5164-4905-9dd2-76ed954900b0"
      runWhenModelUpdates={false}
      showSuccessToaster={false}
      showUpdateSetValueDynamicallyToggle={false}
      updateSetValueDynamically={true}
      warningCodes={[]}
    />
    <SqlQueryUnified
      id="toggle_custom_date_range"
      _additionalScope={["toggle_state"]}
      isMultiplayerEdited={false}
      notificationDuration={4.5}
      query={include("../lib/toggle_custom_date_range.sql", "string")}
      resourceDisplayName="Supabase"
      resourceName="7a13180c-5164-4905-9dd2-76ed954900b0"
      runWhenModelUpdates={false}
      showSuccessToaster={false}
      showUpdateSetValueDynamicallyToggle={false}
      updateSetValueDynamically={true}
      warningCodes={[]}
    />
    <SqlQueryUnified
      id="toggle_utility"
      _additionalScope={["toggle_state"]}
      isMultiplayerEdited={false}
      query={include("../lib/toggle_utility.sql", "string")}
      resourceDisplayName="Supabase"
      resourceName="7a13180c-5164-4905-9dd2-76ed954900b0"
      runWhenModelUpdates={false}
      showSuccessToaster={false}
      warningCodes={[]}
    />
    <SqlQueryUnified
      id="toggle_commissions"
      _additionalScope={["toggle_state"]}
      isMultiplayerEdited={false}
      query={include("../lib/toggle_commissions.sql", "string")}
      resourceDisplayName="Supabase"
      resourceName="7a13180c-5164-4905-9dd2-76ed954900b0"
      runWhenModelUpdates={false}
      showSuccessToaster={false}
      warningCodes={[]}
    />
    <SqlQueryUnified
      id="toggle_all_time_labor_show_move"
      _additionalScope={["toggle_state"]}
      notificationDuration={4.5}
      query={include("../lib/toggle_all_time_labor_show_move.sql", "string")}
      resourceDisplayName="Supabase"
      resourceName="7a13180c-5164-4905-9dd2-76ed954900b0"
      runWhenModelUpdates={false}
      showSuccessToaster={false}
      showUpdateSetValueDynamicallyToggle={false}
      updateSetValueDynamically={true}
      warningCodes={[]}
    />
    <SqlQueryUnified
      id="toggle_all_time_labor_show_junk"
      _additionalScope={["toggle_state"]}
      notificationDuration={4.5}
      query={include("../lib/toggle_all_time_labor_show_junk.sql", "string")}
      resourceDisplayName="Supabase"
      resourceName="7a13180c-5164-4905-9dd2-76ed954900b0"
      runWhenModelUpdates={false}
      showSuccessToaster={false}
      showUpdateSetValueDynamicallyToggle={false}
      updateSetValueDynamically={true}
      warningCodes={[]}
    />
  </Folder>
  <Folder id="setters">
    <SqlQueryUnified
      id="set_move_labor_goal"
      notificationDuration={4.5}
      query={include("../lib/set_move_labor_goal.sql", "string")}
      resourceDisplayName="Supabase - Demo"
      resourceName="b4731250-4b92-46f4-a6f7-45cca5606d79"
      resourceTypeOverride=""
      runWhenModelUpdates={false}
      showSuccessToaster={false}
      showUpdateSetValueDynamicallyToggle={false}
      updateSetValueDynamically={true}
      warningCodes={[]}
    />
    <SqlQueryUnified
      id="set_last_selected_pay_period"
      notificationDuration={4.5}
      query={include("../lib/set_last_selected_pay_period.sql", "string")}
      resourceDisplayName="Supabase - Demo"
      resourceName="b4731250-4b92-46f4-a6f7-45cca5606d79"
      resourceTypeOverride=""
      runWhenModelUpdates={false}
      showSuccessToaster={false}
      warningCodes={[]}
    />
    <SqlQueryUnified
      id="set_last_selected_date_range"
      notificationDuration={4.5}
      query={include("../lib/set_last_selected_date_range.sql", "string")}
      resourceDisplayName="Supabase - Demo"
      resourceName="b4731250-4b92-46f4-a6f7-45cca5606d79"
      resourceTypeOverride=""
      runWhenModelUpdates={false}
      showSuccessToaster={false}
      warningCodes={[]}
    />
    <SqlQueryUnified
      id="set_junk_labor_goal"
      notificationDuration={4.5}
      query={include("../lib/set_junk_labor_goal.sql", "string")}
      resourceDisplayName="Supabase - Demo"
      resourceName="b4731250-4b92-46f4-a6f7-45cca5606d79"
      resourceTypeOverride=""
      runWhenModelUpdates={false}
      showSuccessToaster={false}
      showUpdateSetValueDynamicallyToggle={false}
      updateSetValueDynamically={true}
      warningCodes={[]}
    />
    <SqlQueryUnified
      id="set_bonus_goal"
      notificationDuration={4.5}
      query={include("../lib/set_bonus_goal.sql", "string")}
      resourceDisplayName="Supabase - Demo"
      resourceName="b4731250-4b92-46f4-a6f7-45cca5606d79"
      resourceTypeOverride=""
      runWhenModelUpdates={false}
      showSuccessToaster={false}
      showUpdateSetValueDynamicallyToggle={false}
      updateSetValueDynamically={true}
      warningCodes={[]}
    />
  </Folder>
  <Folder id="supabase_queries">
    <SqlQueryUnified
      id="getLaborData"
      isMultiplayerEdited={false}
      notificationDuration={4.5}
      query={include("../lib/getLaborData.sql", "string")}
      queryTriggerDelay=""
      resourceDisplayName="Supabase - Demo"
      resourceName="b4731250-4b92-46f4-a6f7-45cca5606d79"
      resourceTypeOverride=""
      showSuccessToaster={false}
      showUpdateSetValueDynamicallyToggle={false}
      updateSetValueDynamically={true}
      warningCodes={[]}
    >
      <Event
        id="48eea827"
        enabled=""
        event="success"
        method="run"
        params={{
          map: {
            src: "await getRevenue.trigger();\nawait get_settings.trigger();\nawait Promise.all([\n  get_last_selected_pay_period.trigger(),\n  get_last_selected_date_range.trigger()\n])",
          },
        }}
        pluginId=""
        type="script"
        waitMs="0"
        waitType="debounce"
      />
    </SqlQueryUnified>
    <SqlQueryUnified
      id="getTotalsByDay"
      isMultiplayerEdited={false}
      query={include("../lib/getTotalsByDay.sql", "string")}
      queryDisabled="{{ date_range_end.value && date_range_start.value ? false : true }}"
      resourceDisplayName="Supabase - Demo"
      resourceName="b4731250-4b92-46f4-a6f7-45cca5606d79"
      resourceTypeOverride=""
      warningCodes={[]}
    />
    <SqlQueryUnified
      id="getRevenue"
      isMultiplayerEdited={false}
      query={include("../lib/getRevenue.sql", "string")}
      resourceDisplayName="Supabase - Demo"
      resourceName="b4731250-4b92-46f4-a6f7-45cca5606d79"
      resourceTypeOverride=""
      runWhenModelUpdates={false}
      showSuccessToaster={false}
      warningCodes={[]}
    />
    <SqlQueryUnified
      id="upload_revenue"
      actionType="BULK_UPSERT_BY_KEY"
      bulkUpdatePrimaryKey="Job ID"
      editorMode="gui"
      isMultiplayerEdited={false}
      notificationDuration={4.5}
      records={
        '{{ upload_csv.parsedValue[0].map(row => ({\n  "Job ID": row["Job ID"],\n  "Job Date": row["Start date"],\n  "First Name": row["First name"],\n  "Last Name": row["Last name"],\n  "Address": row["Dest. address"],\n  "Destination State/Prov": row["Dest. state"],\n  "Category": row["Category"],\n  "Status": row["Job status"],\n  "Grand Total": row["Grand total"],\n  "Captain Name": row["Captain"],\n  "Created By": row["Created by"],\n  "Created Date": row["Created date"]\n})) }}'
      }
      resourceDisplayName="Supabase - Demo"
      resourceName="b4731250-4b92-46f4-a6f7-45cca5606d79"
      resourceTypeOverride=""
      runWhenModelUpdates={false}
      showSuccessToaster={false}
      showUpdateSetValueDynamicallyToggle={false}
      tableName="hunkware_rev"
      updateSetValueDynamically={true}
      warningCodes={[]}
    >
      <Event
        id="3da4ef5a"
        event="success"
        method="trigger"
        params={{}}
        pluginId="getLaborData"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        id="ab6b6cfa"
        event="success"
        method="trigger"
        params={{}}
        pluginId="getUnmatchedHunkwareIDs"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </SqlQueryUnified>
    <SqlQueryUnified
      id="getTotalsByCaptainByDay"
      notificationDuration={4.5}
      query={include("../lib/getTotalsByCaptainByDay.sql", "string")}
      resourceDisplayName="Supabase - Demo"
      resourceName="b4731250-4b92-46f4-a6f7-45cca5606d79"
      resourceTypeOverride=""
      runWhenModelUpdates={false}
      showSuccessToaster={false}
      showUpdateSetValueDynamicallyToggle={false}
      updateSetValueDynamically={true}
      warningCodes={[]}
    />
    <SqlQueryUnified
      id="getTotalsByCaptain"
      isMultiplayerEdited={false}
      notificationDuration={4.5}
      query={include("../lib/getTotalsByCaptain.sql", "string")}
      queryDisabled="{{ date_range_end.value && date_range_start.value ? false : true }}"
      resourceDisplayName="Supabase - Demo"
      resourceName="b4731250-4b92-46f4-a6f7-45cca5606d79"
      resourceTypeOverride=""
      showSuccessToaster={false}
      showUpdateSetValueDynamicallyToggle={false}
      updateSetValueDynamically={true}
      warningCodes={[]}
    />
    <SqlQueryUnified
      id="getJunkCommissions"
      isMultiplayerEdited={false}
      query={include("../lib/getJunkCommissions.sql", "string")}
      resourceDisplayName="Supabase - Demo"
      resourceName="b4731250-4b92-46f4-a6f7-45cca5606d79"
      resourceTypeOverride=""
      showFailureToaster={false}
      warningCodes={[]}
    />
    <SqlQueryUnified
      id="getOutofStateLabor"
      _additionalScope={["date_start", "date_end"]}
      isMultiplayerEdited={false}
      query={include("../lib/getOutofStateLabor.sql", "string")}
      resourceDisplayName="Supabase - Demo"
      resourceName="b4731250-4b92-46f4-a6f7-45cca5606d79"
      resourceTypeOverride=""
      runWhenModelUpdates={false}
      showSuccessToaster={false}
      warningCodes={[]}
    />
    <SqlQueryUnified
      id="getMoveCommissions"
      _additionalScope={["date_start", "date_end"]}
      isMultiplayerEdited={false}
      query={include("../lib/getMoveCommissions.sql", "string")}
      resourceDisplayName="Supabase - Demo"
      resourceName="b4731250-4b92-46f4-a6f7-45cca5606d79"
      resourceTypeOverride=""
      runWhenModelUpdates={false}
      showSuccessToaster={false}
      warningCodes={[]}
    />
    <SqlQueryUnified
      id="getJunkCommissionsPrevPP"
      _additionalScope={["date_start", "date_end"]}
      isMultiplayerEdited={false}
      query={include("../lib/getJunkCommissionsPrevPP.sql", "string")}
      resourceDisplayName="Supabase - Demo"
      resourceName="b4731250-4b92-46f4-a6f7-45cca5606d79"
      resourceTypeOverride=""
      warningCodes={[]}
    />
    <SqlQueryUnified
      id="getSalesOfficeLabor"
      query={include("../lib/getSalesOfficeLabor.sql", "string")}
      resourceDisplayName="Supabase - Demo"
      resourceName="b4731250-4b92-46f4-a6f7-45cca5606d79"
      resourceTypeOverride=""
      warningCodes={[]}
    />
    <SqlQueryUnified
      id="getCaptainGraph"
      isMultiplayerEdited={false}
      notificationDuration={4.5}
      query={include("../lib/getCaptainGraph.sql", "string")}
      queryDisabled={
        '{{ captain_graph_date_range.value.start !== "" && captain_graph_date_range.value.end !== "" ? false : true }}'
      }
      resourceDisplayName="Supabase - Demo"
      resourceName="b4731250-4b92-46f4-a6f7-45cca5606d79"
      resourceTypeOverride=""
      showSuccessToaster={false}
      showUpdateSetValueDynamicallyToggle={false}
      updateSetValueDynamically={true}
      warningCodes={[]}
    />
    <SqlQueryUnified
      id="getOverallLaborGraph"
      isMultiplayerEdited={false}
      notificationDuration={4.5}
      query={include("../lib/getOverallLaborGraph.sql", "string")}
      queryDisabled={
        '{{ captain_graph_date_range.value.start !== "" && captain_graph_date_range.value.end !== "" ? false : true }}'
      }
      resourceDisplayName="Supabase - Demo"
      resourceName="b4731250-4b92-46f4-a6f7-45cca5606d79"
      resourceTypeOverride=""
      showSuccessToaster={false}
      showUpdateSetValueDynamicallyToggle={false}
      updateSetValueDynamically={true}
      warningCodes={[]}
    />
    <SqlQueryUnified
      id="getUnmatchedHunkwareIDs"
      isMultiplayerEdited={false}
      query={include("../lib/getUnmatchedHunkwareIDs.sql", "string")}
      resourceDisplayName="Supabase - Demo"
      resourceName="b4731250-4b92-46f4-a6f7-45cca5606d79"
      resourceTypeOverride=""
      showFailureToaster={false}
      warningCodes={[]}
    >
      <Event
        id="35ac9731"
        event="success"
        method="setValue"
        params={{ map: { value: "{{ self.data.hunkware_id }}" } }}
        pluginId="unmatchedHunkwareIDs"
        type="state"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        id="201e1158"
        event="success"
        method="setValue"
        params={{
          map: {
            value:
              "{{ (() => {\n  let data = _.cloneDeep(self.data);\n  let rowCount = data.hunkware_id.length;\n  data._rowId = _.range(rowCount);\n  data.fixed = data.fixed ?? _.fill(Array(rowCount), false);\n  data.notes = data.notes ?? _.fill(Array(rowCount), null);\n  return data;\n})() }}",
          },
        }}
        pluginId="discrepancies_table"
        type="state"
        waitMs="0"
        waitType="debounce"
      />
    </SqlQueryUnified>
    <SqlQueryUnified
      id="getShiftTimeDiscrepancies"
      query={include("../lib/getShiftTimeDiscrepancies.sql", "string")}
      resourceDisplayName="Supabase - Demo"
      resourceName="b4731250-4b92-46f4-a6f7-45cca5606d79"
      resourceTypeOverride=""
      showFailureToaster={false}
      warningCodes={[]}
    />
    <SqlQueryUnified
      id="deleteShift"
      _additionalScope={["id", "date", "shift_team"]}
      confirmationMessage="## Are you sure you want to delete this shift?"
      query={include("../lib/deleteShift.sql", "string")}
      requireConfirmation={true}
      resourceDisplayName="Supabase - Demo"
      resourceName="b4731250-4b92-46f4-a6f7-45cca5606d79"
      resourceTypeOverride=""
      runWhenModelUpdates={false}
      warningCodes={[]}
    >
      <Event
        id="e9b36d01"
        event="success"
        method="refresh"
        params={{}}
        pluginId="unmatched_hunkware_ids_table"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
    </SqlQueryUnified>
    <SqlQueryUnified
      id="getAllCaptainsTotalLaborPercentGraph"
      isMultiplayerEdited={false}
      notificationDuration={4.5}
      query={include(
        "../lib/getAllCaptainsTotalLaborPercentGraph.sql",
        "string"
      )}
      queryDisabled={
        '{{ captain_graph_date_range.value.start !== "" && captain_graph_date_range.value.end !== "" ? false : true }}'
      }
      resourceDisplayName="Supabase - Demo"
      resourceName="b4731250-4b92-46f4-a6f7-45cca5606d79"
      resourceTypeOverride=""
      showFailureToaster={false}
      showSuccessToaster={false}
      showUpdateSetValueDynamicallyToggle={false}
      updateSetValueDynamically={true}
      warningCodes={[]}
    />
    <SqlQueryUnified
      id="laborPctByCrewSize"
      query={include("../lib/laborPctByCrewSize.sql", "string")}
      resourceDisplayName="Supabase - Demo"
      resourceName="b4731250-4b92-46f4-a6f7-45cca5606d79"
      resourceTypeOverride=""
      showFailureToaster={false}
      warningCodes={[]}
    />
    <SqlQueryUnified
      id="getTotalsByWingman"
      isMultiplayerEdited={false}
      query={include("../lib/getTotalsByWingman.sql", "string")}
      resourceDisplayName="Supabase - Demo"
      resourceName="b4731250-4b92-46f4-a6f7-45cca5606d79"
      resourceTypeOverride=""
      showFailureToaster={false}
      warningCodes={[]}
    />
    <SqlQueryUnified
      id="update_discrepancies_table"
      _additionalScope={["payload"]}
      isMultiplayerEdited={false}
      query={include("../lib/update_discrepancies_table.sql", "string")}
      resourceDisplayName="Supabase - Demo"
      resourceName="b4731250-4b92-46f4-a6f7-45cca5606d79"
      resourceTypeOverride=""
      runWhenModelUpdates={false}
      showFailureToaster={false}
      showSuccessToaster={false}
      warningCodes={[]}
    >
      <Event
        id="3c465b6b"
        event="success"
        method="clearChangeset"
        params={{}}
        pluginId="unmatched_hunkware_ids_table"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
    </SqlQueryUnified>
  </Folder>
  <Folder id="js_functions">
    <JavascriptQuery
      id="set_pay_period_to_most_recent"
      _additionalScope={["start"]}
      notificationDuration={4.5}
      query={include("../lib/set_pay_period_to_most_recent.js", "string")}
      resourceName="JavascriptQuery"
      showSuccessToaster={false}
    />
    <JavascriptQuery
      id="set_date_filter_stack"
      _additionalScope={["table", "column", "custom_date"]}
      isMultiplayerEdited={false}
      query={include("../lib/set_date_filter_stack.js", "string")}
      resourceName="JavascriptQuery"
      showSuccessToaster={false}
    />
    <JavascriptQuery
      id="getTotalLabor"
      _additionalScope={["in_labor_type"]}
      isMultiplayerEdited={false}
      notificationDuration={4.5}
      query={include("../lib/getTotalLabor.js", "string")}
      resourceName="JavascriptQuery"
      showSuccessToaster={false}
    />
    <JavascriptQuery
      id="getTotalRev"
      _additionalScope={["job_type1", "job_type2"]}
      isMultiplayerEdited={false}
      query={include("../lib/getTotalRev.js", "string")}
      resourceName="JavascriptQuery"
      showSuccessToaster={false}
    />
    <JavascriptQuery
      id="toStartOfDay"
      _additionalScope={["val"]}
      isMultiplayerEdited={false}
      notificationDuration={4.5}
      query={include("../lib/toStartOfDay.js", "string")}
      resourceName="JavascriptQuery"
      showSuccessToaster={false}
    />
    <JavascriptQuery
      id="toEndOfDay"
      _additionalScope={["val"]}
      isMultiplayerEdited={false}
      notificationDuration={4.5}
      query={include("../lib/toEndOfDay.js", "string")}
      resourceName="JavascriptQuery"
      showSuccessToaster={false}
    />
    <JavascriptQuery id="cache_local_data" resourceName="JavascriptQuery" />
    <JavascriptQuery
      id="get_connecteam_timesheet_discrepancies"
      isMultiplayerEdited={false}
      notificationDuration={4.5}
      query={include(
        "../lib/get_connecteam_timesheet_discrepancies.js",
        "string"
      )}
      resourceName="JavascriptQuery"
      showSuccessToaster={false}
    />
    <JavascriptQuery
      id="discrepancies_upsert_to_db"
      isMultiplayerEdited={false}
      notificationDuration={4.5}
      query={include("../lib/discrepancies_upsert_to_db.js", "string")}
      resourceName="JavascriptQuery"
      showSuccessToaster={false}
    />
  </Folder>
  <RESTQuery
    id="Get_Connecteam_Shift_Data"
    _additionalScope={["overwrite"]}
    body={
      '[{"key":"name","value":"Functions"},{"key":"start","value":"{{ date_range_start.value }}"},{"key":"end","value":"{{ date_range_end.value }}"},{"key":"overwrite","value":"{{ overwrite }}"}]'
    }
    bodyType="json"
    cookies={'[{"key":"","value":""},{"key":"","value":""}]'}
    headers={'[{"key":"Content-Type","value":"application/json"}]'}
    isMultiplayerEdited={false}
    query="connecteam-labor"
    queryDisabled="{{ true }}"
    resourceDisplayName="connecteam_fetch"
    resourceName="574b2811-483f-4dbf-8038-1d27f6f24a72"
    runWhenModelUpdates={false}
    type="POST"
  >
    <Event
      id="8384f4de"
      event="success"
      method="trigger"
      params={{}}
      pluginId="getLaborData"
      type="datasource"
      waitMs="0"
      waitType="debounce"
    />
  </RESTQuery>
  <RESTQuery
    id="Get_Connecteam_Sales_Office_Labor"
    _additionalScope={["overwrite"]}
    body={
      '[{"key":"name","value":"Functions"},{"key":"start","value":"{{ new Date(date_range_start.value).toISOString().split(\\"T\\")[0] }}"},{"key":"end","value":"{{ new Date(date_range_end.value).toISOString().split(\\"T\\")[0] }}"},{"key":"overwrite","value":"{{ overwrite }}"}]'
    }
    bodyType="json"
    cookies={'[{"key":"","value":""},{"key":"","value":""}]'}
    headers={'[{"key":"Content-Type","value":"application/json"}]'}
    isMultiplayerEdited={false}
    query="quick-endpoint"
    queryDisabled="{{ true }}"
    resourceDisplayName="connecteam_fetch"
    resourceName="574b2811-483f-4dbf-8038-1d27f6f24a72"
    runWhenModelUpdates={false}
    showSuccessToaster={false}
    type="POST"
  >
    <Event
      id="8384f4de"
      enabled="{{ !Get_Connecteam_Shift_Data.isFetching || !Get_Hunkware_Revenue_API.isFetching }}"
      event="success"
      method="trigger"
      params={{}}
      pluginId="getLaborData"
      type="datasource"
      waitMs="0"
      waitType="debounce"
    />
  </RESTQuery>
  <RESTQuery
    id="Get_Hunkware_Revenue_API"
    _additionalScope={["overwrite"]}
    body={
      '[{"key":"name","value":"Functions"},{"key":"start","value":"{{ new Date(date_range_start.value).toISOString().split(\\"T\\")[0] }}"},{"key":"end","value":"{{ new Date(date_range_end.value).toISOString().split(\\"T\\")[0] }}"},{"key":"overwrite","value":"{{ overwrite }}"}]'
    }
    bodyType="json"
    cookies={'[{"key":"","value":""},{"key":"","value":""}]'}
    headers={'[{"key":"Content-Type","value":"application/json"}]'}
    isMultiplayerEdited={false}
    query="get-hunkware-rev"
    queryDisabled="{{ true }}"
    resourceDisplayName="connecteam_fetch"
    resourceName="574b2811-483f-4dbf-8038-1d27f6f24a72"
    runWhenModelUpdates={false}
    showSuccessToaster={false}
    type="POST"
  >
    <Event
      id="68e6ccbb"
      enabled="{{ !Get_Connecteam_Shift_Data.isFetching || !Get_Connecteam_Sales_Office_Labor.isFetching }}"
      event="success"
      method="trigger"
      params={{}}
      pluginId="getLaborData"
      type="datasource"
      waitMs="0"
      waitType="debounce"
    />
  </RESTQuery>
  <RESTQuery
    id="Connecteam_Timesheet_Totals"
    body={
      '[{"key":"name","value":"Functions"},{"key":"start","value":"{{ date_range_start.value.toISOString().replace(/T.*/, \\"\\") }}"},{"key":"end","value":"{{ date_range_end.value.toISOString().replace(/T.*/, \\"\\") }}"}]'
    }
    bodyType="json"
    headers={'[{"key":"Content-Type","value":"application/json"}]'}
    isMultiplayerEdited={false}
    query="get-connecteam-timesheet"
    queryDisabled="{{ true }}"
    queryTimeout="20000"
    resourceDisplayName="connecteam_fetch"
    resourceName="574b2811-483f-4dbf-8038-1d27f6f24a72"
    resourceTypeOverride=""
    runWhenModelUpdates={false}
    showFailureToaster={false}
    showSuccessToaster={false}
    type="POST"
  />
  <RESTQuery
    id="Connecteam_Shifts"
    body={
      '[{"key":"name","value":"Functions"},{"key":"start","value":"{{ Math.floor(date_range_start.value.getTime() / 1000) }}"},{"key":"end","value":"{{ Math.floor(date_range_end.value.getTime() / 1000) + 82800 }}"}]'
    }
    bodyType="json"
    headers={'[{"key":"Content-Type","value":"application/json"}]'}
    isMultiplayerEdited={false}
    query="get-connecteam-shifts"
    queryDisabled="{{ true }}"
    resourceDisplayName="connecteam_fetch"
    resourceName="574b2811-483f-4dbf-8038-1d27f6f24a72"
    resourceTypeOverride=""
    runWhenModelUpdates={false}
    showSuccessToaster={false}
    type="POST"
  />
  <JavascriptQuery
    id="testRev"
    isMultiplayerEdited={false}
    notificationDuration={4.5}
    query={include("../lib/testRev.js", "string")}
    resourceName="JavascriptQuery"
    showSuccessToaster={false}
  />
  <JavascriptQuery
    id="query1"
    notificationDuration={4.5}
    query={include("../lib/query1.js", "string")}
    resourceName="JavascriptQuery"
    runWhenPageLoads={true}
    showSuccessToaster={false}
  />
  <Include src="./captain_graph_modal.rsx" />
  <Include src="./captain_total_labor_graph_modal.rsx" />
  <Include src="./discrepancies_modal.rsx" />
  <Include src="./overall_graph_modal.rsx" />
  <Include src="./tutorial.rsx" />
  <Frame
    id="$main"
    enableFullBleed={false}
    isHiddenOnDesktop={false}
    isHiddenOnMobile={false}
    padding="0"
    style={{ map: { canvas: "canvas" } }}
    type="main"
  >
    <Navigation
      id="navigation3"
      data="{{ retoolContext.pages }}"
      highlightByIndex="{{ retoolContext.currentPage === item.id }}"
      labels="{{ item.title || item.id }}"
      retoolStorageFileId="b0e3f054-dd42-489c-a8fc-442ff1d961a0"
      src="data:image/svg+xml,%3csvg%20width='70'%20height='24'%20fill='none'%20xmlns='http://www.w3.org/2000/svg'%3e%3ccircle%20cx='10'%20cy='12'%20r='10'%20fill='%23B3B3B3'/%3e%3cpath%20d='M9.283%207.069c.218-.705%201.216-.705%201.434%200l.713%202.309a.75.75%200%200%200%20.717.528h2.386c.717%200%201.025.91.455%201.346l-1.994%201.524a.75.75%200%200%200-.261.817l.746%202.415c.215.698-.592%201.26-1.172.817l-1.852-1.414a.75.75%200%200%200-.91%200l-1.852%201.414c-.58.444-1.388-.12-1.172-.817l.746-2.415a.75.75%200%200%200-.261-.817l-1.994-1.524c-.57-.435-.262-1.346.455-1.346h2.386a.75.75%200%200%200%20.717-.528l.713-2.31Z'%20fill='%23fff'%20stroke='%23fff'%20stroke-width='.375'/%3e%3cpath%20d='M27.138%2018V4.91h2.767v10.808h5.613V18h-8.38Zm14.598.192c-.993%200-1.852-.211-2.576-.633a4.33%204.33%200%200%201-1.669-1.777c-.392-.763-.588-1.647-.588-2.653%200-1.014.196-1.9.588-2.659a4.28%204.28%200%200%201%201.669-1.777c.724-.426%201.583-.639%202.576-.639.992%200%201.849.213%202.57.64a4.266%204.266%200%200%201%201.674%201.776c.392.759.588%201.645.588%202.66%200%201.005-.196%201.89-.588%202.652a4.317%204.317%200%200%201-1.675%201.777c-.72.422-1.577.633-2.57.633Zm.012-2.11c.452%200%20.83-.128%201.132-.383.302-.26.53-.614.684-1.061.157-.448.236-.957.236-1.528%200-.57-.079-1.08-.236-1.528-.154-.447-.382-.8-.684-1.06-.303-.26-.68-.39-1.132-.39-.456%200-.84.13-1.15.39-.307.26-.54.613-.697%201.06-.153.448-.23.957-.23%201.528%200%20.571.077%201.08.23%201.528.158.447.39.8.697%201.06.31.256.694.384%201.15.384Zm11.014%205.804c-.882%200-1.639-.121-2.27-.364-.626-.239-1.124-.565-1.495-.978a3.006%203.006%200%200%201-.722-1.393l2.518-.34c.077.197.198.38.364.55.167.171.386.307.659.41.277.106.613.16%201.01.16.592%200%201.08-.146%201.464-.435.387-.286.581-.765.581-1.438V16.26h-.115c-.12.273-.298.53-.537.774a2.707%202.707%200%200%201-.92.594c-.375.154-.823.23-1.343.23a4.03%204.03%200%200%201-2.013-.511c-.6-.345-1.08-.871-1.438-1.579-.354-.712-.53-1.61-.53-2.697%200-1.112.18-2.041.543-2.787.362-.746.843-1.304%201.444-1.675a3.733%203.733%200%200%201%201.988-.556c.55%200%201.01.094%201.38.281.372.183.67.414.896.69.23.273.407.542.53.806h.102V8.18h2.704v9.915c0%20.835-.204%201.534-.613%202.096-.41.563-.976.985-1.7%201.266-.72.286-1.55.428-2.487.428Zm.057-6.072c.44%200%20.81-.109%201.113-.326.306-.222.54-.537.703-.946.166-.413.25-.908.25-1.483%200-.575-.082-1.074-.244-1.496-.162-.426-.396-.756-.703-.99-.307-.235-.68-.352-1.119-.352-.447%200-.824.121-1.131.364-.307.239-.539.571-.697.997-.157.426-.236.919-.236%201.477%200%20.567.079%201.057.236%201.47.162.41.395.727.697.953.307.221.684.332%201.131.332Zm11.346%202.378c-.993%200-1.851-.211-2.576-.633a4.33%204.33%200%200%201-1.668-1.777c-.392-.763-.588-1.647-.588-2.653%200-1.014.196-1.9.588-2.659a4.278%204.278%200%200%201%201.668-1.777c.725-.426%201.583-.639%202.576-.639.993%200%201.85.213%202.57.64a4.267%204.267%200%200%201%201.675%201.776c.392.759.588%201.645.588%202.66%200%201.005-.196%201.89-.588%202.652a4.317%204.317%200%200%201-1.675%201.777c-.72.422-1.577.633-2.57.633Zm.013-2.11c.452%200%20.829-.128%201.132-.383.302-.26.53-.614.683-1.061.158-.448.237-.957.237-1.528%200-.57-.079-1.08-.237-1.528-.153-.447-.381-.8-.683-1.06-.303-.26-.68-.39-1.132-.39-.456%200-.84.13-1.15.39-.307.26-.54.613-.697%201.06-.154.448-.23.957-.23%201.528%200%20.571.076%201.08.23%201.528.157.447.39.8.697%201.06.31.256.694.384%201.15.384Z'%20fill='%23555'/%3e%3c/svg%3e"
      srcType="retoolStorageFileId"
      style={{ fontSize: "h6Font", fontWeight: "h6Font", fontFamily: "h6Font" }}
    >
      <Option id="00030" icon="bold/interface-home-3" label="Home" />
      <Option
        id="00031"
        icon="bold/interface-user-multiple"
        label="Customers"
      />
      <Option id="00032" icon="bold/interface-setting-cog" label="Settings" />
      <Event
        id="mockEventHandlerId1"
        event="click"
        method="openPage"
        params={{ map: { pageName: "{{ item.id }}" } }}
        pluginId=""
        type="util"
        waitMs="0"
        waitType="debounce"
      />
    </Navigation>
    <Divider id="divider2" style={{}} />
    <Select
      id="select_pay_period"
      data="{{ calculate_pay_periods.data }}"
      emptyMessage="No options"
      label="Select Pay Period"
      labelPosition="top"
      overlayMaxHeight={375}
      placeholder="Select a pay period"
      showSelectionIndicator={true}
      value=""
      values="{{ item }}"
    >
      <Event
        id="0bc0425c"
        enabled={
          '{{ \n// Update with new date ranges when needed\nmoment().isAfter(moment(select_pay_period.data[0].split("-")[1], "M/D/YYYY"), "day")\n}}'
        }
        event="focus"
        method="trigger"
        params={{}}
        pluginId="calculate_pay_periods"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        id="0bc0425c"
        enabled="{{ self.value !== null && self.value !== undefined }}"
        event="change"
        method="setFilterStack"
        params={{
          map: {
            filterStack: {
              filters:
                '[{"columnId": \'date\', "operator": \'>=\', value: {{ \n`${new Date(self.value.split("-")[0]).toLocaleDateString().split("/")[2]}-${new Date(self.value.split("-")[0]).toLocaleDateString().split("/")[0].padStart(2,0)}-${new Date(self.value.split("-")[0]).toLocaleDateString().split("/")[1].padStart(2,0)}` }} }, {"columnId": \'date\', "operator": \'<=\', "value": {{ `${new Date(self.value.split("-")[1]).toLocaleDateString().split("/")[2]}-${new Date(self.value.split("-")[1]).toLocaleDateString().split("/")[0].padStart(2,0)}-${new Date(self.value.split("-")[1]).toLocaleDateString().split("/")[1].padStart(2,0)}` }} }]',
              operator: "and",
            },
          },
        }}
        pluginId="labor_data"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        id="0bc0425c"
        enabled="{{ self.value !== null && self.value !== undefined }}"
        event="change"
        method="setFilterStack"
        params={{
          map: {
            filterStack: {
              filters:
                '[{"columnId": \'Job Date\', "operator": \'>=\', value: {{ \n`${new Date(self.value.split("-")[0]).toLocaleDateString().split("/")[2]}-${new Date(self.value.split("-")[0]).toLocaleDateString().split("/")[0].padStart(2,0)}-${new Date(self.value.split("-")[0]).toLocaleDateString().split("/")[1].padStart(2,0)}` }} }, {"columnId": \'Job Date\', "operator": \'<=\', "value": {{ `${new Date(self.value.split("-")[1]).toLocaleDateString().split("/")[2]}-${new Date(self.value.split("-")[1]).toLocaleDateString().split("/")[0].padStart(2,0)}-${new Date(self.value.split("-")[1]).toLocaleDateString().split("/")[1].padStart(2,0)}` }} }]',
              operator: "and",
            },
          },
        }}
        pluginId="hunkware_rev"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        id="0bc0425c"
        enabled="{{ self.value !== null && self.value !== undefined }}"
        event="change"
        method="setFilterStack"
        params={{
          map: {
            filterStack: {
              filters:
                '[{"columnId": \'date\', "operator": \'>=\', value: {{ \n`${new Date(self.value.split("-")[0]).toLocaleDateString().split("/")[2]}-${new Date(self.value.split("-")[0]).toLocaleDateString().split("/")[0].padStart(2,0)}-${new Date(self.value.split("-")[0]).toLocaleDateString().split("/")[1].padStart(2,0)}` }} }, {"columnId": \'date\', "operator": \'<=\', "value": {{ `${new Date(self.value.split("-")[1]).toLocaleDateString().split("/")[2]}-${new Date(self.value.split("-")[1]).toLocaleDateString().split("/")[0].padStart(2,0)}-${new Date(self.value.split("-")[1]).toLocaleDateString().split("/")[1].padStart(2,0)}` }} }]',
              operator: "and",
            },
          },
        }}
        pluginId="sales_office_labor"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        id="29e6478a"
        enabled="{{ self.value !== null && self.value !== undefined }}"
        event="change"
        method="setValue"
        params={{
          map: {
            value:
              '{{ self.value\n    ? moment(self.value.split("-")[0].trim(), "M/D/YYYY").toISOString()\n    : null }}',
          },
        }}
        pluginId="date_range_start"
        type="state"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        id="7a23b007"
        enabled="{{ self.value !== null && self.value !== undefined }}"
        event="change"
        method="setValue"
        params={{
          map: {
            value:
              '{{ moment(self.value.split("-")[1].trim(), "M/D/YYYY").hour(18).toISOString() }}',
          },
        }}
        pluginId="date_range_end"
        type="state"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        id="6ca4c0aa"
        event="change"
        method="trigger"
        params={{}}
        pluginId="set_last_selected_pay_period"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        id="a9237f6b"
        enabled={
          '{{ !(moment(self.value.split("-")[0], "M/D/YYYY").isAfter(moment.utc(most_recent_labordata_date), "day") || moment(self.value.split("-")[1], "M/D/YYYY").isAfter(moment.utc(most_recent_labordata_date), "day")) }}'
        }
        event="change"
        method="trigger"
        params={{
          map: {
            options: {
              onSuccess: null,
              onFailure: null,
              additionalScope: { map: { in_labor_type: '"Move"' } },
            },
          },
        }}
        pluginId="getTotalLabor"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        id="ff93894c"
        enabled={
          '{{ !(moment(self.value.split("-")[0], "M/D/YYYY").isAfter(moment.utc(most_recent_labordata_date), "day") || moment(self.value.split("-")[1], "M/D/YYYY").isAfter(moment.utc(most_recent_labordata_date), "day")) }}'
        }
        event="change"
        method="trigger"
        params={{
          map: {
            options: {
              map: { additionalScope: { map: { in_labor_type: '"Junk"' } } },
            },
          },
        }}
        pluginId="getTotalLabor"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        id="ff93894c"
        enabled={
          '{{ !(moment(self.value.split("-")[0], "M/D/YYYY").isAfter(moment.utc(most_recent_labordata_date), "day") || moment(self.value.split("-")[1], "M/D/YYYY").isAfter(moment.utc(most_recent_labordata_date), "day")) }}'
        }
        event="change"
        method="trigger"
        params={{
          map: {
            options: {
              map: {
                additionalScope: {
                  job_type1: "Moving",
                  job_type2: "Move Labor",
                },
              },
            },
          },
        }}
        pluginId="getTotalRev"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        id="ff93894c"
        enabled={
          '{{ !(moment(self.value.split("-")[0], "M/D/YYYY").isAfter(moment.utc(most_recent_labordata_date), "day") || moment(self.value.split("-")[1], "M/D/YYYY").isAfter(moment.utc(most_recent_labordata_date), "day")) }}'
        }
        event="change"
        method="trigger"
        params={{
          map: {
            options: {
              map: {
                additionalScope: {
                  job_type1: "Labor",
                  job_type2: "Junk Removal",
                },
              },
            },
          },
        }}
        pluginId="getTotalRev"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        id="728ba653"
        event="change"
        method="setValue"
        params={{ map: { value: "{{ false }}" } }}
        pluginId="use_custom_date_range"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        id="2bc456db"
        event="change"
        method="trigger"
        params={{
          map: {
            options: {
              map: {
                additionalScope: { map: { toggle_state: "{{ false }}" } },
              },
            },
          },
        }}
        pluginId="toggle_custom_date_range"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        id="46712b03"
        event="change"
        method="trigger"
        params={{}}
        pluginId="get_connecteam_timesheet_discrepancies"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </Select>
    <DateRange
      id="custom_date_range"
      dateFormat="MMM d, yyyy"
      endPlaceholder="End date"
      iconBefore="bold/interface-calendar-remove"
      label="Custom Date Range"
      labelPosition="top"
      showClear={true}
      startPlaceholder="Start date"
      textBetween="-"
      value={{ start: "", end: "" }}
    >
      <Event
        id="08635701"
        enabled=""
        event="blur"
        method="setFilterStack"
        params={{
          map: {
            filterStack: {
              filters:
                '[{"columnId": \'date\', "operator": \'>=\', value: {{ self.value.start }} }, {"columnId": \'date\', "operator": \'<=\', "value": {{ self.value.end }} }]',
              operator: "and",
            },
          },
        }}
        pluginId="labor_data"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        id="08635701"
        enabled=""
        event="blur"
        method="setFilterStack"
        params={{
          map: {
            filterStack: {
              filters:
                '[{"columnId": \'date\', "operator": \'>=\', value: {{ self.value.start }} }, {"columnId": \'date\', "operator": \'<=\', "value": {{ self.value.end }} }]',
              operator: "and",
            },
          },
        }}
        pluginId="sales_office_labor"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        id="a789f3b2"
        enabled=""
        event="blur"
        method="setValue"
        params={{
          map: {
            value: '{{ moment(self.value.start, "YYYY-M-D").toISOString() }}',
          },
        }}
        pluginId="date_range_start"
        type="state"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        id="33d4a9da"
        event="blur"
        method="setValue"
        params={{
          map: {
            value:
              '{{ moment(self.value.start, "YYYY-M-D").hour(18).toISOString() }}',
          },
        }}
        pluginId="date_range_end"
        type="state"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        id="b58b9f17"
        enabled={
          '{{ (self.value.end !== "" || self.value.end !== null) && (self.value.start !== "" || self.value.start !== null) }}'
        }
        event="blur"
        method="trigger"
        params={{}}
        pluginId="set_last_selected_date_range"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        id="c9fa1b25"
        enabled="{{ !(custom_date_range.value.start > most_recent_labordata_date.value || custom_date_range.value.end > most_recent_labordata_date.value) }}"
        event="blur"
        method="trigger"
        params={{
          map: {
            options: {
              map: { additionalScope: { map: { in_labor_type: '"Move"' } } },
            },
          },
        }}
        pluginId="getTotalLabor"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        id="c9fa1b25"
        enabled="{{ !(custom_date_range.value.start > most_recent_labordata_date.value || custom_date_range.value.end > most_recent_labordata_date.value) }}"
        event="blur"
        method="trigger"
        params={{
          map: {
            options: {
              map: { additionalScope: { map: { in_labor_type: '"Junk"' } } },
            },
          },
        }}
        pluginId="getTotalLabor"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        id="c9fa1b25"
        enabled="{{ !(custom_date_range.value.start > most_recent_labordata_date.value || custom_date_range.value.end > most_recent_labordata_date.value) }}"
        event="blur"
        method="trigger"
        params={{
          map: {
            options: {
              map: {
                additionalScope: {
                  job_type1: "Moving",
                  job_type2: "Move Labor",
                },
              },
            },
          },
        }}
        pluginId="getTotalRev"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        id="c9fa1b25"
        enabled="{{ !(custom_date_range.value.start > most_recent_labordata_date.value || custom_date_range.value.end > most_recent_labordata_date.value) }}"
        event="blur"
        method="trigger"
        params={{
          map: {
            options: {
              map: {
                additionalScope: {
                  job_type1: "Labor",
                  job_type2: "Junk Removal",
                },
              },
            },
          },
        }}
        pluginId="getTotalRev"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        id="25dd53ef"
        event="blur"
        method="setValue"
        params={{ map: { value: "{{ true }}" } }}
        pluginId="use_custom_date_range"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        id="fe6e1e74"
        event="blur"
        method="trigger"
        params={{
          map: {
            options: {
              map: { additionalScope: { map: { toggle_state: "{{ true }}" } } },
            },
          },
        }}
        pluginId="toggle_custom_date_range"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        id="64618f47"
        event="blur"
        method="trigger"
        params={{}}
        pluginId="getTotalsByCaptain"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        id="600dc6c5"
        event="blur"
        method="trigger"
        params={{}}
        pluginId="get_connecteam_timesheet_discrepancies"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </DateRange>
    <FileButton
      id="upload_csv"
      _isUpgraded={true}
      accept="['csv']"
      hidden="true"
      iconBefore="bold/programming-browser-search"
      maxCount={20}
      maxSize="250mb"
      parseFiles={true}
      styleVariant="outline"
      text="Upload Hunkware Revenue Sheet"
    >
      <Event
        id="0500a99c"
        enabled=""
        event="parse"
        method="trigger"
        params={{ map: { options: { map: { additionalScope: {} } } } }}
        pluginId="upload_revenue"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </FileButton>
    <Switch id="use_custom_date_range" label="Use Custom Date Range">
      <Event
        id="c02e0815"
        enabled=""
        event="change"
        method="run"
        params={{
          map: {
            src: 'await toggle_custom_date_range.trigger({\nadditionalScope: {toggle_state: use_custom_date_range.value}\n})\n\nif (use_custom_date_range.value === true) {\n  if (custom_date_range.value.start !== "" && custom_date_range.value.end !== "") {\n    // Set date range to current custom date range\n    const start = custom_date_range.value.start;\n    const end = custom_date_range.value.end;\n    date_range_start.setValue(start)\n    date_range_end.setValue(end)\n    \n    await set_date_filter_stack.trigger({additionalScope: {table: sales_office_labor, column: \'date\', custom_date: true}})\n    getTotalsByDay.trigger()\n  }\n} else {\n  date_range_start.setValue(select_pay_period.value.split("-")[0])\n  date_range_end.setValue(select_pay_period.value.split("-")[1])\n    \n  await set_date_filter_stack.trigger({additionalScope: {table: sales_office_labor, column: \'date\', custom_date: false}})\n  getTotalsByDay.trigger()\n}\n\nawait Promise.all([\n  getTotalLabor.trigger({additionalScope: {in_labor_type: "Move"}}),\n  getTotalLabor.trigger({additionalScope: {in_labor_type: "Junk"}}),\n  getTotalRev.trigger({additionalScope: {job_type1: "Moving", job_type2: "Move Labor"}}),\n  getTotalRev.trigger({additionalScope: {job_type1: "Junk Removal", job_type2: "Labor"}}),\n  getTotalsByCaptain.trigger(),\n  get_connecteam_timesheet_discrepancies.trigger()\n])\n',
          },
        }}
        pluginId=""
        type="script"
        waitMs="100"
        waitType="debounce"
      />
    </Switch>
    <Icon
      id="icon1"
      disabled="{{ Get_Connecteam_Shift_Data.isFetching || Get_Hunkware_Revenue_API.isFetching || Get_Connecteam_Sales_Office_Labor.isFetching }}"
      horizontalAlign="center"
      icon="bold/interface-arrows-synchronize"
      style={{}}
      tooltipText="Re-fetches all API data, overwriting data for the selected Pay Period."
    >
      <Event
        id="5a482676"
        event="click"
        method="trigger"
        params={{
          map: {
            options: {
              map: { additionalScope: { map: { overwrite: "true" } } },
            },
          },
        }}
        pluginId="Get_Connecteam_Shift_Data"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        id="5a482676"
        event="click"
        method="trigger"
        params={{
          map: {
            options: {
              map: { additionalScope: { map: { overwrite: "true" } } },
            },
          },
        }}
        pluginId="Get_Connecteam_Sales_Office_Labor"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        id="5a482676"
        event="click"
        method="trigger"
        params={{
          map: {
            options: {
              map: { additionalScope: { map: { overwrite: "true" } } },
            },
          },
        }}
        pluginId="Get_Hunkware_Revenue_API"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        id="394928ba"
        event="click"
        method="showNotification"
        params={{
          map: {
            options: {
              notificationType: "info",
              title: "Re-fetching API Data",
            },
          },
        }}
        pluginId=""
        type="util"
        waitMs="0"
        waitType="debounce"
      />
    </Icon>
    <Alert2
      id="alert3"
      hidden="{{ initialVersion.value === latestVersion.value }}"
      value="warning"
    >
      <State
        id="0"
        actionIconPositions="right"
        actionPositions="bottom"
        actionTexts="Action"
        actionTooltips={null}
        backgroundColors={null}
        borderColors={null}
        colors={null}
        descriptions="Description"
        iconPositions="center"
        icons="bold/interface-alert-information-circle"
        styleVariants="info"
        titles="Info"
        tooltips={null}
        values="info"
      />
      <State
        id="1"
        actionIconPositions="right"
        actionPositions="bottom"
        actionTexts="Action"
        actionTooltips={null}
        backgroundColors={null}
        borderColors={null}
        colors={null}
        descriptions="Description"
        iconPositions="center"
        icons="bold/interface-validation-check-circle"
        styleVariants="success"
        titles="Success"
        tooltips={null}
        values="success"
      />
      <State
        id="2"
        actionIconPositions="left"
        actionIcons="bold/interface-arrows-synchronize"
        actionPositions="bottom"
        actionTexts="Refresh"
        actionTooltips="Refreshes the page"
        backgroundColors={null}
        borderColors={null}
        colors={null}
        descriptions="The app has an update, please refresh to apply."
        iconPositions="center"
        icons="bold/interface-alert-warning-triangle"
        styleVariants="warning"
        titles="Update Pending"
        tooltips={null}
        values="warning"
      >
        <Event
          id="e49c31ba"
          event="click"
          method="run"
          params={{
            map: {
              src: "utils.openUrl(`https://example.retool.com/apps/PRODUCTION_APP_ID/App/${retoolContext.currentPage}`, {newTab: false, forceReload: true})",
            },
          }}
          pluginId=""
          type="script"
          waitMs="0"
          waitType="debounce"
        />
      </State>
      <State
        id="3"
        actionIconPositions="right"
        actionPositions="bottom"
        actionTexts="Action"
        actionTooltips={null}
        backgroundColors={null}
        borderColors={null}
        colors={null}
        descriptions="Description"
        iconPositions="center"
        icons="bold/interface-delete-circle"
        styleVariants="error"
        titles="Error"
        tooltips={null}
        values="error"
      />
    </Alert2>
    <Divider id="divider1" />
    <Text
      id="labor_goals_text"
      style={{ fontSize: "h5Font", fontWeight: "h5Font", fontFamily: "h5Font" }}
      value="Labor % Goals"
      verticalAlign="center"
    />
    <Statistic
      id="total_move_labor_stat"
      currency="USD"
      formattingStyle="currency"
      label="Move Labor"
      labelCaption={
        "Since last {{ use_custom_date_range.value ? Math.ceil(moment(custom_date_range.value.end).endOf('day').diff(moment(custom_date_range.value.start).startOf('day'),'days',true)) + \" days\" : \"pay period\" }}"
      }
      positiveTrend="{{ self.value >= 0 }}"
      secondaryCurrency="USD"
      secondaryDecimalPlaces="2"
      secondaryEnableTrend={true}
      secondaryFormattingStyle="percent"
      secondaryPositiveTrend="{{ self.secondaryValue <= 0 }}"
      secondaryShowSeparators={true}
      secondarySignDisplay="trendArrows"
      secondaryValue=""
      showSeparators={true}
      value="{{ totalMoveLabor.value }}"
    />
    <Statistic
      id="total_move_rev_stat"
      currency="USD"
      formattingStyle="currency"
      label="Move Revenue"
      labelCaption={
        "Since last {{ use_custom_date_range.value ? Math.ceil(moment(custom_date_range.value.end).endOf('day').diff(moment(custom_date_range.value.start).startOf('day'),'days',true)) + \" days\" : \"pay period\" }}"
      }
      positiveTrend="{{ self.value >= 0 }}"
      secondaryCurrency="USD"
      secondaryDecimalPlaces="2"
      secondaryEnableTrend={true}
      secondaryFormattingStyle="percent"
      secondaryPositiveTrend="{{ self.secondaryValue >= 0 }}"
      secondaryShowSeparators={true}
      secondarySignDisplay="trendArrows"
      secondaryValue=""
      showSeparators={true}
      value="{{ totalMoveRev.value }}"
    />
    <Statistic
      id="total_move_labor_pct_stat"
      currency="USD"
      decimalPlaces="2"
      formattingStyle="percent"
      label="Move Labor %"
      labelCaption={
        "Since last {{ use_custom_date_range.value ? Math.ceil(moment(custom_date_range.value.end).endOf('day').diff(moment(custom_date_range.value.start).startOf('day'),'days',true)) + \" days\" : \"pay period\" }}"
      }
      positiveTrend="{{ self.value >= 0 }}"
      secondaryCurrency="USD"
      secondaryDecimalPlaces="2"
      secondaryEnableTrend={true}
      secondaryFormattingStyle="percent"
      secondaryPositiveTrend="{{ self.secondaryValue <= 0 }}"
      secondaryShowSeparators={true}
      secondarySignDisplay="trendArrows"
      secondaryValue="{{ ((total_move_labor_stat.value / total_move_rev_stat.value) - (totalMoveLaborPrevPP.value / totalMoveRevPrevPP.value)) / (totalMoveLaborPrevPP.value / totalMoveRevPrevPP.value) }}"
      showSeparators={true}
      value="{{ total_move_labor_stat.value / total_move_rev_stat.value }}"
    />
    <NumberInput
      id="move_labor_goal"
      currency="USD"
      format="percent"
      inputValue={0}
      label="Move"
      labelWidth="24"
      max={1}
      min={0}
      placeholder="Enter value"
      showSeparators={true}
      showStepper={true}
      style={{
        sharedLabelFontSize: "h6Font",
        sharedLabelFontWeight: "h6Font",
        sharedLabelFontFamily: "h6Font",
      }}
      value={0}
    >
      <Event
        id="ac661193"
        event="change"
        method="trigger"
        params={{ map: { options: { map: { additionalScope: {} } } } }}
        pluginId="set_move_labor_goal"
        type="datasource"
        waitMs="100"
        waitType="debounce"
      />
    </NumberInput>
    <NumberInput
      id="junk_labor_goal"
      currency="USD"
      format="percent"
      inputValue={0}
      label="Junk"
      labelWidth="24"
      max={1}
      min={0}
      placeholder="Enter value"
      showSeparators={true}
      showStepper={true}
      style={{
        sharedLabelFontSize: "h6Font",
        sharedLabelFontWeight: "h6Font",
        sharedLabelFontFamily: "h6Font",
      }}
      value={0}
    >
      <Event
        id="4de5b1b1"
        event="change"
        method="trigger"
        params={{}}
        pluginId="set_junk_labor_goal"
        type="datasource"
        waitMs="100"
        waitType="debounce"
      />
    </NumberInput>
    <Statistic
      id="total_junk_labor_stat"
      currency="USD"
      formattingStyle="currency"
      label="Junk Labor"
      labelCaption={
        "Since last {{ use_custom_date_range.value ? Math.ceil(moment(custom_date_range.value.end).endOf('day').diff(moment(custom_date_range.value.start).startOf('day'),'days',true)) + \" days\" : \"pay period\" }}"
      }
      positiveTrend="{{ self.value >= 0 }}"
      secondaryCurrency="USD"
      secondaryDecimalPlaces="2"
      secondaryEnableTrend={true}
      secondaryFormattingStyle="percent"
      secondaryPositiveTrend="{{ self.secondaryValue <= 0 }}"
      secondaryShowSeparators={true}
      secondarySignDisplay="trendArrows"
      secondaryValue=""
      showSeparators={true}
      value="{{ totalJunkLabor.value }}"
    />
    <Statistic
      id="total_junk_rev_stat"
      currency="USD"
      formattingStyle="currency"
      label="Junk Revenue"
      labelCaption={
        "Since last {{ use_custom_date_range.value ? Math.ceil(moment(custom_date_range.value.end).endOf('day').diff(moment(custom_date_range.value.start).startOf('day'),'days',true)) + \" days\" : \"pay period\" }}"
      }
      positiveTrend="{{ self.value >= 0 }}"
      secondaryCurrency="USD"
      secondaryDecimalPlaces="2"
      secondaryEnableTrend={true}
      secondaryFormattingStyle="percent"
      secondaryPositiveTrend="{{ self.secondaryValue >= 0 }}"
      secondaryShowSeparators={true}
      secondarySignDisplay="trendArrows"
      secondaryValue=""
      showSeparators={true}
      value="{{ totalJunkRev.value }}"
    />
    <Statistic
      id="total_junk_labor_pct_stat"
      currency="USD"
      decimalPlaces="2"
      formattingStyle="percent"
      label="Junk Labor %"
      labelCaption={
        "Since last {{ use_custom_date_range.value ? Math.ceil(moment(custom_date_range.value.end).endOf('day').diff(moment(custom_date_range.value.start).startOf('day'),'days',true)) + \" days\" : \"pay period\" }}"
      }
      positiveTrend="{{ self.value >= 0 }}"
      secondaryCurrency="USD"
      secondaryDecimalPlaces="2"
      secondaryEnableTrend={true}
      secondaryFormattingStyle="percent"
      secondaryPositiveTrend="{{ self.secondaryValue <= 0 }}"
      secondaryShowSeparators={true}
      secondarySignDisplay="trendArrows"
      secondaryValue="{{ ((total_junk_labor_stat.value / total_junk_rev_stat.value) - (totalJunkLaborPrevPP.value / totalJunkRevPrevPP.value)) / (totalJunkLaborPrevPP.value / totalJunkRevPrevPP.value) }}"
      showSeparators={true}
      value="{{ total_junk_labor_stat.value / total_junk_rev_stat.value }}"
    />
    <Container
      id="options_container"
      footerPadding="4px 12px"
      headerPadding="4px 12px"
      padding="12px"
      showBody={true}
      showHeader={true}
    >
      <Header>
        <Text
          id="containerTitle1"
          value="#### Options"
          verticalAlign="center"
        />
      </Header>
      <View id="00030" viewKey="View 1">
        <Switch id="include_out_of_state" label="Include Out of State">
          <Event
            id="d2da7d3f"
            event="change"
            method="trigger"
            params={{
              map: {
                options: {
                  onSuccess: null,
                  onFailure: null,
                  additionalScope: {
                    map: { toggle_state: "{{ self.value }}" },
                  },
                },
              },
            }}
            pluginId="toggle_out_of_state"
            type="datasource"
            waitMs="0"
            waitType="debounce"
          />
          <Event
            id="a8af3bbc"
            event="change"
            method="trigger"
            params={{
              map: {
                options: {
                  map: { additionalScope: { map: { in_labor_type: "Move" } } },
                },
              },
            }}
            pluginId="getTotalLabor"
            type="datasource"
            waitMs="0"
            waitType="debounce"
          />
          <Event
            id="8289ab76"
            event="change"
            method="trigger"
            params={{
              map: {
                options: {
                  map: {
                    additionalScope: {
                      job_type1: "Moving",
                      job_type2: "Move Labor",
                    },
                  },
                },
              },
            }}
            pluginId="getTotalRev"
            type="datasource"
            waitMs="0"
            waitType="debounce"
          />
        </Switch>
        <Switch id="include_utility" label="Include Utility">
          <Event
            id="d2da7d3f"
            event="change"
            method="trigger"
            params={{
              map: {
                options: {
                  onSuccess: null,
                  onFailure: null,
                  additionalScope: {
                    map: { toggle_state: "{{ self.value }}" },
                  },
                },
              },
            }}
            pluginId="toggle_utility"
            type="datasource"
            waitMs="0"
            waitType="debounce"
          />
          <Event
            id="5e0571a1"
            event="change"
            method="trigger"
            params={{
              map: {
                options: {
                  map: { additionalScope: { map: { in_labor_type: "Junk" } } },
                },
              },
            }}
            pluginId="getTotalLabor"
            type="datasource"
            waitMs="0"
            waitType="debounce"
          />
        </Switch>
        <Switch id="include_commissions" label="Include Commissions">
          <Event
            id="d2da7d3f"
            event="change"
            method="trigger"
            params={{
              map: {
                options: {
                  onSuccess: null,
                  onFailure: null,
                  additionalScope: {
                    map: { toggle_state: "{{ self.value }}" },
                  },
                },
              },
            }}
            pluginId="toggle_commissions"
            type="datasource"
            waitMs="0"
            waitType="debounce"
          />
          <Event
            id="fad9856e"
            event="change"
            method="trigger"
            params={{
              map: {
                options: {
                  map: { additionalScope: { map: { in_labor_type: "Move" } } },
                },
              },
            }}
            pluginId="getTotalLabor"
            type="datasource"
            waitMs="0"
            waitType="debounce"
          />
          <Event
            id="2acf8140"
            event="change"
            method="trigger"
            params={{
              map: {
                options: {
                  map: { additionalScope: { map: { in_labor_type: "Junk" } } },
                },
              },
            }}
            pluginId="getTotalLabor"
            type="datasource"
            waitMs="0"
            waitType="debounce"
          />
        </Switch>
      </View>
    </Container>
    <Statistic
      id="total_overall_rev_stat"
      currency="USD"
      formattingStyle="currency"
      label="Overall Revenue"
      labelCaption={
        "Since last {{ use_custom_date_range.value ? Math.ceil(moment(custom_date_range.value.end).endOf('day').diff(moment(custom_date_range.value.start).startOf('day'),'days',true)) + \" days\" : \"pay period\" }}"
      }
      positiveTrend="{{ self.value >= 0 }}"
      secondaryCurrency="USD"
      secondaryDecimalPlaces="2"
      secondaryEnableTrend={true}
      secondaryFormattingStyle="percent"
      secondaryPositiveTrend="{{ self.secondaryValue >= 0 }}"
      secondaryShowSeparators={true}
      secondarySignDisplay="trendArrows"
      secondaryValue=""
      showSeparators={true}
      value="{{ totalMoveRev.value + totalJunkRev.value }}"
    />
    <Statistic
      id="total_overall_labor_pct_stat"
      currency="USD"
      decimalPlaces="2"
      formattingStyle="percent"
      label="Overall Labor %"
      labelCaption={
        "Since last {{ use_custom_date_range.value ? Math.ceil(moment(custom_date_range.value.end).endOf('day').diff(moment(custom_date_range.value.start).startOf('day'),'days',true)) + \" days\" : \"pay period\" }}"
      }
      positiveTrend="{{ self.value >= 0 }}"
      secondaryCurrency="USD"
      secondaryDecimalPlaces="2"
      secondaryEnableTrend={true}
      secondaryFormattingStyle="percent"
      secondaryPositiveTrend="{{ self.secondaryValue <= 0 }}"
      secondaryShowSeparators={true}
      secondarySignDisplay="trendArrows"
      secondaryValue="{{ ((total_overall_labor_stat.value / total_overall_rev_stat.value) - ((totalMoveLaborPrevPP.value + totalJunkLaborPrevPP.value) / (totalMoveRevPrevPP.value + totalJunkRevPrevPP.value))) / ((totalMoveLaborPrevPP.value + totalJunkLaborPrevPP.value) / (totalMoveRevPrevPP.value + totalJunkRevPrevPP.value)) }}"
      showSeparators={true}
      value="{{ total_overall_labor_stat.value / total_overall_rev_stat.value }}"
    />
    <Statistic
      id="total_overall_labor_stat"
      currency="USD"
      formattingStyle="currency"
      label="Overall Labor"
      labelCaption={
        "Since last {{ use_custom_date_range.value ? Math.ceil(moment(custom_date_range.value.end).endOf('day').diff(moment(custom_date_range.value.start).startOf('day'),'days',true)) + \" days\" : \"pay period\" }}"
      }
      positiveTrend="{{ self.value >= 0 }}"
      secondaryCurrency="USD"
      secondaryDecimalPlaces="2"
      secondaryEnableTrend={true}
      secondaryFormattingStyle="percent"
      secondaryPositiveTrend="{{ self.secondaryValue <= 0 }}"
      secondaryShowSeparators={true}
      secondarySignDisplay="trendArrows"
      secondaryValue=""
      showSeparators={true}
      value="{{ totalMoveLabor.value + totalJunkLabor.value }}"
    />
    <Text id="text1" value="#### Totals by Day" verticalAlign="center" />
    <Button id="labor_graph_button" text="Total Labor % Graph">
      <Event
        id="cb52d3f1"
        event="click"
        method="show"
        params={{}}
        pluginId="overall_graph_modal"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
    </Button>
    <Container
      id="discrepancies_container"
      footerPadding="4px 12px"
      headerPadding="4px 12px"
      hidden={
        '{{ hunkware_rev.data.filter(r => {\n    const jobDate = r["Job Date"];\n    const start = moment(date_range_start.value).format("YYYY-MM-DD");\n    const end = moment(date_range_end.value).format("YYYY-MM-DD");\n    return (r["Captain Name"] === "" || r["Captain Name"] === null) \n      && ["Closed", "Completed"].includes(r.Status) \n      && jobDate >= start \n      && jobDate <= end;\n}).length == 0 && unmatchedHunkwareIDs.value.length == 0 && new Set(labor_data.data.filter(r => (r.captain === "" || r.captain === null) && new Date(r.date) >= date_range_start.value && new Date(r.date) <= date_range_end.value && r.laborType === "Junk").map(r => r.shift_team)).size == 0 }}'
      }
      padding="12px"
      showBody={true}
      showHeader={true}
      style={{
        background: "rgba(220, 38, 38, 0.1)",
        border: "rgba(220, 38, 38, 0.2)",
      }}
    >
      <Header>
        <Text
          id="discrepancies_title"
          value="#### Discrepancies"
          verticalAlign="center"
        />
      </Header>
      <View id="00030" viewKey="View 1">
        <Text
          id="discrepancies_body"
          hidden=""
          style={{ fontSize: "13px", fontWeight: "400", fontFamily: "Inter" }}
          value={
            'Missing Captains in Revenue Sheet: {{ hunkware_rev.data.filter(r => {\n    const jobDate = r["Job Date"];\n    const start = moment(date_range_start.value).format("YYYY-MM-DD");\n    const end = moment(date_range_end.value).format("YYYY-MM-DD");\n    return (r["Captain Name"] === "" || r["Captain Name"] === null) \n      && ["Closed", "Completed"].includes(r.Status) \n      && jobDate >= start \n      && jobDate <= end;\n}).length }}\nUnassigned Captains in Labor: {{ new Set(labor_data.data.filter(r => (r.captain === "" || r.captain === null) && new Date(r.date) >= date_range_start.value && new Date(r.date) <= date_range_end.value && r.laborType === "Junk").map(r => r.shift_team)).size }}\nUnmatched Hunkware IDs: {{ unmatchedHunkwareIDs.value.length }}'
          }
          verticalAlign="center"
        />
        <Icon
          id="discrepancies_icon"
          horizontalAlign="center"
          icon="bold/interface-delete-circle"
          margin="0"
          style={{ map: { color: "danger" } }}
        />
        <Link
          id="discrepancies_link"
          showUnderline="never"
          style={{ map: { text: "danger" } }}
          text="Show Discrepancies"
        >
          <Event
            id="2b9f323e"
            event="click"
            method="show"
            params={{}}
            pluginId="discrepancies_modal"
            type="widget"
            waitMs="0"
            waitType="debounce"
          />
        </Link>
      </View>
    </Container>
    <Table
      id="totals_by_day"
      autoColumnWidth={true}
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ getTotalsByDay.data }}"
      defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
      emptyMessage="No rows found"
      enableSaveActions={true}
      heightType="auto"
      primaryKeyColumnId="c7d05"
      showBorder={true}
      showFooter={true}
      showHeader={true}
      showSummaryRow={true}
      style={{}}
      toolbarPosition="bottom"
    >
      <Column
        id="c7d05"
        alignment="left"
        editable={false}
        format="date"
        groupAggregationMode="none"
        key="date"
        label="Date"
        placeholder="Enter value"
        position="center"
        size={42.68333435058594}
        summaryAggregationMode="none"
      />
      <Column
        id="7b938"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="currency"
        formatOptions={{
          currency: "USD",
          currencySign: "standard",
          notation: "standard",
          showSeparators: true,
          currencyDisplay: "symbol",
        }}
        groupAggregationMode="sum"
        key="move_labor"
        label="Move Labor"
        placeholder="Enter value"
        position="center"
        size={83}
        summaryAggregationMode="sum"
      />
      <Column
        id="57daf"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="currency"
        formatOptions={{
          currency: "USD",
          currencySign: "standard",
          notation: "standard",
          showSeparators: true,
          currencyDisplay: "symbol",
        }}
        groupAggregationMode="sum"
        key="move_revenue"
        label="Move Rev"
        placeholder="Enter value"
        position="center"
        size={71.46665954589844}
        summaryAggregationMode="sum"
      />
      <Column
        id="9ae2c"
        alignment="right"
        backgroundColor={
          '{{ !item || item === "" || parseFloat(item) <= 0 ? "" : parseFloat(item) >= move_labor_goal.value ? theme.danger : "#0d0d0d" }}'
        }
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="average"
        key="move_labor_pct"
        label="Move Labor %"
        placeholder="Enter value"
        position="center"
        size={96.13333129882812}
      />
      <Column
        id="41f82"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="false"
        key="move_jobs"
        label="Move Jobs"
        placeholder="Enter value"
        position="center"
        size={77.80000305175781}
        summaryAggregationMode="sum"
      />
      <Column
        id="cdd22"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="currency"
        formatOptions={{
          currency: "USD",
          currencySign: "standard",
          notation: "standard",
          showSeparators: true,
          currencyDisplay: "symbol",
        }}
        groupAggregationMode="sum"
        key="junk_labor"
        label="Junk Labor"
        placeholder="Enter value"
        position="center"
        size={79.01666259765625}
        summaryAggregationMode="sum"
      />
      <Column
        id="81560"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="currency"
        formatOptions={{
          currency: "USD",
          currencySign: "standard",
          notation: "standard",
          showSeparators: true,
          currencyDisplay: "symbol",
        }}
        groupAggregationMode="sum"
        key="junk_revenue"
        label="Junk Rev"
        placeholder="Enter value"
        position="center"
        size={67.48333740234375}
        summaryAggregationMode="sum"
      />
      <Column
        id="f7b21"
        alignment="right"
        backgroundColor={
          '{{ !item || item === "" || parseFloat(item) <= 0 ? "" : parseFloat(item) >= junk_labor_goal.value ? theme.danger : "#0d0d0d" }}'
        }
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="average"
        key="junk_labor_pct"
        label="Junk Labor %"
        placeholder="Enter value"
        position="center"
        size={92.14999389648438}
      />
      <Column
        id="7c6dd"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="junk_jobs"
        label="Junk Jobs"
        placeholder="Enter value"
        position="center"
        size={73.81666564941406}
        summaryAggregationMode="sum"
      />
      <Column
        id="2cd00"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="currency"
        formatOptions={{
          currency: "USD",
          currencySign: "standard",
          notation: "standard",
          showSeparators: true,
          currencyDisplay: "symbol",
        }}
        groupAggregationMode="sum"
        key="overall_labor"
        label="Overall Labor"
        placeholder="Enter value"
        position="center"
        size={91.48333740234375}
        summaryAggregationMode="sum"
      />
      <Column
        id="cca04"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="currency"
        formatOptions={{
          currency: "USD",
          currencySign: "standard",
          notation: "standard",
          showSeparators: true,
          currencyDisplay: "symbol",
        }}
        groupAggregationMode="sum"
        key="overall_revenue"
        label="Overall Rev"
        placeholder="Enter value"
        position="center"
        size={79.94999694824219}
        summaryAggregationMode="sum"
      />
      <Column
        id="886d2"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="average"
        key="overall_labor_pct"
        label="Overall Labor %"
        placeholder="Enter value"
        position="center"
        size={104.61666870117188}
      />
      <Column
        id="4930a"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="overall_jobs"
        label="Overall Jobs"
        placeholder="Enter value"
        position="center"
        size={86.28334045410156}
        summaryAggregationMode="sum"
      />
      <ToolbarButton
        id="1a"
        icon="bold/interface-text-formatting-filter-2"
        label="Filter"
        type="filter"
      />
      <ToolbarButton
        id="3c"
        icon="bold/interface-download-button-2"
        label="Download"
        type="custom"
      >
        <Event
          id="3f0845fe"
          event="clickToolbar"
          method="exportData"
          pluginId="totals_by_day"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
      <ToolbarButton
        id="4d"
        icon="bold/interface-arrows-round-left"
        label="Refresh"
        type="custom"
      >
        <Event
          id="f0aac6c2"
          event="clickToolbar"
          method="refresh"
          pluginId="totals_by_day"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
    </Table>
    <Text
      id="text2"
      value="#### {{ TotalsBy_container.currentViewKey }}"
      verticalAlign="center"
    />
    <Button
      id="captain_total_labor_pct_graph_btn"
      text="Captain All-Time Labor % Graph"
    >
      <Event
        id="cb52d3f1"
        event="click"
        method="show"
        params={{}}
        pluginId="captain_total_labor_graph_modal"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
    </Button>
    <Container
      id="TotalsBy_container"
      currentViewKey="{{ self.viewKeys[0] }}"
      footerPadding="4px 12px"
      headerPadding="4px 12px"
      hidden=""
      hoistFetching={true}
      padding="12px"
      showBody={true}
      showHeader={true}
      transition="slide"
    >
      <Header>
        <Tabs
          id="tabs1"
          itemMode="static"
          navigateContainer={true}
          targetContainerId="TotalsBy_container"
          value="{{ self.values[0] }}"
        >
          <Option id="00030" value="Tab 1" />
          <Option id="00031" value="Tab 2" />
          <Option id="00032" value="Tab 3" />
        </Tabs>
      </Header>
      <View id="00030" viewKey="Totals by Captain">
        <Table
          id="totals_by_captain"
          actionsOverflowPosition={1}
          autoColumnWidth={true}
          cellSelection="none"
          clearChangesetOnSave={true}
          data="{{ getTotalsByCaptain.data }}"
          defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
          emptyMessage="No rows found"
          enableSaveActions={true}
          heightType="auto"
          showBorder={true}
          showFooter={true}
          showHeader={true}
          showSummaryRow={true}
          toolbarPosition="bottom"
        >
          <Column
            id="bbea8"
            alignment="left"
            editable={false}
            editableOptions={{ spellCheck: false }}
            format="string"
            groupAggregationMode="none"
            key="captain"
            label="Captain"
            placeholder="Enter value"
            position="center"
            size={59.81666564941406}
            summaryAggregationMode="none"
          />
          <Column
            id="8ca34"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="currency"
            formatOptions={{
              currency: "USD",
              currencySign: "standard",
              notation: "standard",
              showSeparators: true,
              currencyDisplay: "symbol",
            }}
            groupAggregationMode="sum"
            key="move_labor"
            label="Move Labor"
            placeholder="Enter value"
            position="center"
            size={83}
            summaryAggregationMode="sum"
          />
          <Column
            id="60522"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="currency"
            formatOptions={{
              currency: "USD",
              currencySign: "standard",
              notation: "standard",
              showSeparators: true,
              currencyDisplay: "symbol",
            }}
            groupAggregationMode="sum"
            hidden="{{ include_commissions.value == false }}"
            key="move_commission"
            label="Move Commission"
            placeholder="Enter value"
            position="center"
            size={119.58332824707031}
            summaryAggregationMode="sum"
          />
          <Column
            id="c3ab5"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="currency"
            formatOptions={{
              currency: "USD",
              currencySign: "standard",
              notation: "standard",
              showSeparators: true,
              currencyDisplay: "symbol",
            }}
            groupAggregationMode="sum"
            key="move_revenue"
            label="Move Revenue"
            placeholder="Enter value"
            position="center"
            size={99.18333435058594}
            summaryAggregationMode="sum"
          />
          <Column
            id="1170a"
            alignment="right"
            backgroundColor={
              '{{ !item || item === "" || parseFloat(item) <= 0 ? "" : parseFloat(item) >= move_labor_goal.value ? theme.danger : "#0d0d0d" }}'
            }
            editableOptions={{ showStepper: true }}
            format="percent"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "2",
            }}
            groupAggregationMode="average"
            key="move_labor_pct"
            label="Move Labor %"
            placeholder="Enter value"
            position="center"
            size={96.13333129882812}
          />
          <Column
            id="b9771"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="move_jobs"
            label="Move Jobs"
            placeholder="Enter value"
            position="center"
            size={77.80000305175781}
            summaryAggregationMode="sum"
          />
          <Column
            id="62eff"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="currency"
            formatOptions={{
              currency: "USD",
              currencySign: "standard",
              notation: "standard",
              showSeparators: true,
              currencyDisplay: "symbol",
            }}
            groupAggregationMode="sum"
            key="move_ajs"
            label="Move AJS"
            placeholder="Enter value"
            position="center"
            size={72.68333435058594}
            summaryAggregationMode="sum"
          />
          <Column
            id="993ce"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="currency"
            formatOptions={{
              currency: "USD",
              currencySign: "standard",
              notation: "standard",
              showSeparators: true,
              currencyDisplay: "symbol",
            }}
            groupAggregationMode="sum"
            key="junk_labor"
            label="Junk Labor"
            placeholder="Enter value"
            position="center"
            size={79.01666259765625}
            summaryAggregationMode="sum"
          />
          <Column
            id="89122"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="currency"
            formatOptions={{
              currency: "USD",
              currencySign: "standard",
              notation: "standard",
              showSeparators: true,
              currencyDisplay: "symbol",
            }}
            groupAggregationMode="sum"
            hidden="{{ include_commissions.value == false }}"
            label="Junk Commission"
            placeholder="Enter value"
            position="center"
            referenceId="junk_commission"
            size={115.60000610351562}
            summaryAggregationMode="sum"
            valueOverride="{{ junk_commissions.data.find(r => r.captain === currentSourceRow.captain)?.adjusted_bonus }}"
          />
          <Column
            id="6591d"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="currency"
            formatOptions={{
              currency: "USD",
              currencySign: "standard",
              notation: "standard",
              showSeparators: true,
              currencyDisplay: "symbol",
            }}
            groupAggregationMode="sum"
            key="junk_revenue"
            label="Junk Revenue"
            placeholder="Enter value"
            position="center"
            size={95.19999694824219}
            summaryAggregationMode="sum"
          />
          <Column
            id="fa91b"
            alignment="right"
            backgroundColor={
              '{{ !item || item === "" || parseFloat(item) <= 0 ? "" : parseFloat(item) >= junk_labor_goal.value ? theme.danger : "#0d0d0d" }}'
            }
            editableOptions={{ showStepper: true }}
            format="percent"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "2",
            }}
            groupAggregationMode="average"
            key="junk_labor_pct"
            label="Junk Labor %"
            placeholder="Enter value"
            position="center"
            size={92.14999389648438}
            valueOverride="{{ include_commissions.value && currentSourceRow.junk_labor > 0 ? (_.toNumber(currentSourceRow.junk_labor) + _.toNumber(capt_junk_commissions_transformer.value[i])) / _.toNumber(currentSourceRow.junk_revenue) : item }}"
          />
          <Column
            id="d00f3"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="junk_jobs"
            label="Junk Jobs"
            placeholder="Enter value"
            position="center"
            size={73.81666564941406}
            summaryAggregationMode="sum"
          />
          <Column
            id="84bff"
            alignment="right"
            cellTooltip="{{ item }}"
            cellTooltipMode="custom"
            editableOptions={{ showStepper: true }}
            format="currency"
            formatOptions={{
              currency: "USD",
              currencySign: "standard",
              notation: "standard",
              showSeparators: true,
              currencyDisplay: "symbol",
            }}
            groupAggregationMode="sum"
            key="junk_ajs"
            label="Junk AJS"
            placeholder="Enter value"
            position="center"
            size={68.69999694824219}
            summaryAggregationMode="sum"
          />
          <Action id="5a068" icon="bold/money-graph" label="Open Graph">
            <Event
              id="9c2ac594"
              event="clickAction"
              method="show"
              params={{}}
              pluginId="captain_graph_modal"
              type="widget"
              waitMs="0"
              waitType="debounce"
            />
          </Action>
          <ToolbarButton
            id="1a"
            icon="bold/interface-text-formatting-filter-2"
            label="Filter"
            type="filter"
          />
          <ToolbarButton
            id="3c"
            icon="bold/interface-download-button-2"
            label="Download"
            type="custom"
          >
            <Event
              id="3cf722ac"
              event="clickToolbar"
              method="exportData"
              pluginId="totals_by_captain"
              type="widget"
              waitMs="0"
              waitType="debounce"
            />
          </ToolbarButton>
          <ToolbarButton
            id="4d"
            icon="bold/interface-arrows-round-left"
            label="Refresh"
            type="custom"
          >
            <Event
              id="0ad03b15"
              event="clickToolbar"
              method="refresh"
              pluginId="totals_by_captain"
              type="widget"
              waitMs="0"
              waitType="debounce"
            />
          </ToolbarButton>
        </Table>
      </View>
      <View id="00031" viewKey="Totals by Wingman">
        <Table
          id="totalsByWingmen_table"
          autoColumnWidth={true}
          cellSelection="none"
          clearChangesetOnSave={true}
          data="{{ getTotalsByWingman.data }}"
          defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
          emptyMessage="No rows found"
          enableSaveActions={true}
          heightType="auto"
          showBorder={true}
          showFooter={true}
          showHeader={true}
          toolbarPosition="bottom"
        >
          <Column
            id="71793"
            alignment="left"
            editableOptions={{ spellCheck: false }}
            format="string"
            groupAggregationMode="none"
            key="name"
            label="Wingman"
            placeholder="Enter value"
            position="center"
            size={161.3000030517578}
          />
          <Column
            id="80a33"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="currency"
            formatOptions={{
              currency: "USD",
              currencySign: "standard",
              notation: "standard",
              showSeparators: true,
              currencyDisplay: "symbol",
            }}
            groupAggregationMode="sum"
            key="move_labor"
            label="Move Labor"
            placeholder="Enter value"
            position="center"
            size={83}
          />
          <Column
            id="eee6c"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="currency"
            formatOptions={{
              currency: "USD",
              currencySign: "standard",
              notation: "standard",
              showSeparators: true,
              currencyDisplay: "symbol",
            }}
            groupAggregationMode="sum"
            hidden="{{ include_commissions.value == false }}"
            key="move_commission"
            label="Move Commission"
            placeholder="Enter value"
            position="center"
            size={119.58332824707031}
          />
          <Column
            id="39f84"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="currency"
            formatOptions={{
              currency: "USD",
              currencySign: "standard",
              notation: "standard",
              showSeparators: true,
              currencyDisplay: "symbol",
            }}
            groupAggregationMode="sum"
            key="move_revenue"
            label="Move Revenue"
            placeholder="Enter value"
            position="center"
            size={99.18333435058594}
          />
          <Column
            id="18262"
            alignment="right"
            backgroundColor={
              '{{ !item || item === "" || parseFloat(item) <= 0 ? "" : parseFloat(item) >= move_labor_goal.value ? theme.danger : "#0d0d0d" }}'
            }
            editableOptions={{ showStepper: true }}
            format="percent"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "2",
            }}
            groupAggregationMode="average"
            key="move_labor_pct"
            label="Move Labor %"
            placeholder="Enter value"
            position="center"
            size={96.13333129882812}
          />
          <Column
            id="3904c"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="move_jobs"
            label="Move Jobs"
            placeholder="Enter value"
            position="center"
            size={77.80000305175781}
          />
          <Column
            id="0d3bf"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="currency"
            formatOptions={{
              currency: "USD",
              currencySign: "standard",
              notation: "standard",
              showSeparators: true,
              currencyDisplay: "symbol",
            }}
            groupAggregationMode="sum"
            key="move_ajs"
            label="Move AJS"
            placeholder="Enter value"
            position="center"
            size={73.86666870117188}
          />
          <Column
            id="2b682"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="currency"
            formatOptions={{
              currency: "USD",
              currencySign: "standard",
              notation: "standard",
              showSeparators: true,
              currencyDisplay: "symbol",
            }}
            groupAggregationMode="sum"
            key="junk_labor"
            label="Junk Labor"
            placeholder="Enter value"
            position="center"
            size={79.01666259765625}
          />
          <Column
            id="ac417"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="currency"
            formatOptions={{
              currency: "USD",
              currencySign: "standard",
              notation: "standard",
              showSeparators: true,
              currencyDisplay: "symbol",
            }}
            groupAggregationMode="sum"
            key="junk_revenue"
            label="Junk Revenue"
            placeholder="Enter value"
            position="center"
            size={95.19999694824219}
          />
          <Column
            id="cfdee"
            alignment="right"
            backgroundColor={
              '{{ !item || item === "" || parseFloat(item) <= 0 ? "" : parseFloat(item) >= junk_labor_goal.value ? theme.danger : "#0d0d0d" }}'
            }
            editableOptions={{ showStepper: true }}
            format="percent"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "2",
            }}
            groupAggregationMode="average"
            key="junk_labor_pct"
            label="Junk Labor %"
            placeholder="Enter value"
            position="center"
            size={92.14999389648438}
          />
          <Column
            id="716aa"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="junk_jobs"
            label="Junk Jobs"
            placeholder="Enter value"
            position="center"
            size={73.81666564941406}
          />
          <Column
            id="1b413"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="currency"
            formatOptions={{
              currency: "USD",
              currencySign: "standard",
              notation: "standard",
              showSeparators: true,
              currencyDisplay: "symbol",
            }}
            groupAggregationMode="sum"
            key="junk_ajs"
            label="Junk AJS"
            placeholder="Enter value"
            position="center"
            size={73.96665954589844}
          />
          <ToolbarButton
            id="1a"
            icon="bold/interface-text-formatting-filter-2"
            label="Filter"
            type="filter"
          />
          <ToolbarButton
            id="3c"
            icon="bold/interface-download-button-2"
            label="Download"
            type="custom"
          >
            <Event
              id="b0184994"
              event="clickToolbar"
              method="exportData"
              pluginId="totalsByWingmen_table"
              type="widget"
              waitMs="0"
              waitType="debounce"
            />
          </ToolbarButton>
          <ToolbarButton
            id="4d"
            icon="bold/interface-arrows-round-left"
            label="Refresh"
            type="custom"
          >
            <Event
              id="74fbc262"
              event="clickToolbar"
              method="refresh"
              pluginId="totalsByWingmen_table"
              type="widget"
              waitMs="0"
              waitType="debounce"
            />
          </ToolbarButton>
        </Table>
      </View>
    </Container>
    <NumberInput
      id="bonus_goal"
      currency="USD"
      format="percent"
      inputValue={0}
      label="Bonus Goal"
      labelPosition="top"
      placeholder="Enter value"
      showSeparators={true}
      showStepper={true}
      style={{
        sharedLabelFontSize: "h6Font",
        sharedLabelFontWeight: "h6Font",
        sharedLabelFontFamily: "h6Font",
      }}
      value={0}
    >
      <Event
        id="69723c5c"
        event="change"
        method="trigger"
        params={{}}
        pluginId="set_bonus_goal"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </NumberInput>
    <Text id="text3" value="#### Junk Commissions" verticalAlign="center" />
    <Table
      id="junk_commissions"
      autoColumnWidth={true}
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ getJunkCommissions.data }}"
      defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
      defaultSort={[]}
      emptyMessage="No rows found"
      enableSaveActions={true}
      groupByColumns={{}}
      heightType="auto"
      primaryKeyColumnId="b4a8e"
      showBorder={true}
      showFooter={true}
      showHeader={true}
      showSummaryRow={true}
      toolbarPosition="bottom"
    >
      <Column
        id="b4a8e"
        alignment="left"
        editable={false}
        editableOptions={{ spellCheck: false }}
        format="string"
        groupAggregationMode="none"
        key="captain"
        label="Captain"
        placeholder="Enter value"
        position="center"
        size={120.80000305175781}
        summaryAggregationMode="none"
      />
      <Column
        id="02dca"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="currency"
        formatOptions={{
          currency: "USD",
          currencySign: "standard",
          notation: "standard",
          showSeparators: true,
          currencyDisplay: "symbol",
        }}
        groupAggregationMode="sum"
        key="raw_bonus"
        label="Bonus"
        placeholder="Enter value"
        position="center"
        size={61.98333740234375}
        summaryAggregationMode="sum"
      />
      <Column
        id="25a14"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="currency"
        formatOptions={{
          currency: "USD",
          currencySign: "standard",
          notation: "standard",
          showSeparators: true,
          currencyDisplay: "symbol",
        }}
        groupAggregationMode="sum"
        key="adjusted_bonus"
        label="Adj Bonus"
        placeholder="Enter value"
        position="center"
        size={73.01666259765625}
        summaryAggregationMode="sum"
      />
      <Column
        id="9e39d"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="currency"
        formatOptions={{
          currency: "USD",
          currencySign: "standard",
          notation: "standard",
          showSeparators: true,
          currencyDisplay: "symbol",
        }}
        groupAggregationMode="sum"
        key="junk_labor"
        label="Junk Labor"
        placeholder="Enter value"
        position="center"
        size={79.01666259765625}
        summaryAggregationMode="sum"
      />
      <Column
        id="eb76e"
        alignment="right"
        cellTooltip="{{ item }}"
        cellTooltipMode="custom"
        editableOptions={{ showStepper: true }}
        format="currency"
        formatOptions={{
          currency: "USD",
          currencySign: "standard",
          notation: "standard",
          showSeparators: true,
          currencyDisplay: "symbol",
        }}
        groupAggregationMode="sum"
        key="junk_revenue"
        label="Junk Revenue"
        placeholder="Enter value"
        position="center"
        size={95.19999694824219}
        summaryAggregationMode="sum"
      />
      <Column
        id="76629"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "2",
        }}
        groupAggregationMode="average"
        key="junk_labor_pct"
        label="Junk Labor %"
        placeholder="Enter value"
        position="center"
        size={92.14999389648438}
      />
      <Column
        id="d6f24"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="junk_jobs"
        label="Junk Jobs"
        placeholder="Enter value"
        position="center"
        size={73.81666564941406}
        summaryAggregationMode="sum"
      />
      <Column
        id="ec388"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="currency"
        formatOptions={{
          currency: "USD",
          currencySign: "standard",
          notation: "standard",
          showSeparators: true,
          currencyDisplay: "symbol",
        }}
        groupAggregationMode="sum"
        key="junk_ajs"
        label="Junk AJS"
        placeholder="Enter value"
        position="center"
        size={68.69999694824219}
        summaryAggregationMode="sum"
      />
      <ToolbarButton
        id="1a"
        icon="bold/interface-text-formatting-filter-2"
        label="Filter"
        type="filter"
      />
      <ToolbarButton
        id="3c"
        icon="bold/interface-download-button-2"
        label="Download"
        type="custom"
      >
        <Event
          id="f114ace8"
          event="clickToolbar"
          method="exportData"
          pluginId="junk_commissions"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
      <ToolbarButton
        id="4d"
        icon="bold/interface-arrows-round-left"
        label="Refresh"
        type="custom"
      >
        <Event
          id="f187dd5a"
          event="clickToolbar"
          method="refresh"
          pluginId="junk_commissions"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
    </Table>
    <Text
      id="text8"
      value="#### Sales and Office Labor"
      verticalAlign="center"
    />
    <Table
      id="sales_office_labor"
      autoColumnWidth={true}
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ getSalesOfficeLabor.data }}"
      defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
      emptyMessage="No rows found"
      enableSaveActions={true}
      groupByColumns={[
        { map: { columnId: "4ae9b" } },
        { map: { columnId: "d676f" } },
        { map: { columnId: "824b2" } },
      ]}
      groupedColumnConfig={{ expandByDefault: true }}
      heightType="auto"
      primaryKeyColumnId="ecc73"
      rowHeight="small"
      showBorder={true}
      showFooter={true}
      showHeader={true}
      showSummaryRow={true}
      toolbarPosition="bottom"
    >
      <Column
        id="9f097"
        alignment="left"
        format="datetime"
        groupAggregationMode="none"
        hidden="true"
        key="created_at"
        label="Created at"
        placeholder="Enter value"
        position="center"
        size={0}
        summaryAggregationMode="none"
      />
      <Column
        id="ecc73"
        alignment="left"
        editable="false"
        editableOptions={{ spellCheck: false }}
        format="string"
        groupAggregationMode="none"
        hidden="true"
        key="hash"
        label="Hash"
        placeholder="Enter value"
        position="center"
        size={0}
        summaryAggregationMode="none"
      />
      <Column
        id="296f4"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="currency"
        formatOptions={{
          currency: "USD",
          currencySign: "standard",
          notation: "standard",
          showSeparators: true,
          currencyDisplay: "symbol",
        }}
        groupAggregationMode="sum"
        key="labor"
        label="Labor"
        placeholder="Enter value"
        position="center"
        size={60.91667175292969}
        summaryAggregationMode="sum"
      />
      <Column
        id="9f864"
        alignment="left"
        editable={false}
        format="date"
        groupAggregationMode="none"
        key="date"
        label="Date"
        placeholder="Enter value"
        position="center"
        size={83.23333740234375}
        summaryAggregationMode="none"
      />
      <Column
        id="641db"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="true"
        key="user_id"
        label="User ID"
        placeholder="Enter value"
        position="center"
        size={0}
      />
      <Column
        id="d676f"
        alignment="left"
        editable={false}
        format="tag"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="labor_type"
        label="Labor type"
        placeholder="Select option"
        position="center"
        size={119.69999694824219}
        summaryAggregationMode="none"
        valueOverride="{{ _.startCase(item) }}"
      />
      <Column
        id="824b2"
        alignment="left"
        editable="false"
        editableOptions={{ spellCheck: false }}
        format="string"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="name"
        label="Name"
        placeholder="Enter value"
        position="center"
        size={105.91667175292969}
        summaryAggregationMode="none"
        valueOverride="{{ _.startCase(item) }}"
      />
      <Column
        id="4ae9b"
        alignment="left"
        editable="false"
        editableOptions={{ spellCheck: false }}
        format="string"
        groupAggregationMode="none"
        label="Labor Group"
        placeholder="Enter value"
        position="center"
        referenceId="laborGroup"
        size={86.61666870117188}
        summaryAggregationMode="none"
        valueOverride={
          "{{ (['Office Manager', 'Crew Lead']).includes(currentSourceRow.labor_type) ? \"Office\" : \"Sales\" }}"
        }
      />
      <ToolbarButton
        id="1a"
        icon="bold/interface-text-formatting-filter-2"
        label="Filter"
        type="filter"
      />
      <ToolbarButton
        id="3c"
        icon="bold/interface-download-button-2"
        label="Download"
        type="custom"
      >
        <Event
          id="7bfc0006"
          event="clickToolbar"
          method="exportData"
          pluginId="sales_office_labor"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
      <ToolbarButton
        id="4d"
        icon="bold/interface-arrows-round-left"
        label="Refresh"
        type="custom"
      >
        <Event
          id="9409e830"
          event="clickToolbar"
          method="refresh"
          pluginId="sales_office_labor"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
    </Table>
    <Table
      id="labor_data"
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ getLaborData.data }}"
      defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
      emptyMessage="No rows found"
      enableSaveActions={true}
      groupByColumns={{}}
      hidden="true"
      overflowType="pagination"
      persistRowSelection={true}
      primaryKeyColumnId="ad1d8"
      showBorder={true}
      showFooter={true}
      showHeader={true}
      templatePageSize="14"
      toolbarPosition="bottom"
    >
      <Column
        id="c88c7"
        alignment="left"
        format="date"
        groupAggregationMode="none"
        key="date"
        label="Date"
        placeholder="Enter value"
        position="center"
        size={111}
      />
      <Column
        id="0812b"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="currency"
        formatOptions={{
          currency: "USD",
          currencySign: "standard",
          notation: "standard",
          showSeparators: true,
          currencyDisplay: "symbol",
        }}
        groupAggregationMode="sum"
        key="labor"
        label="Labor"
        placeholder="Enter value"
        position="center"
        size={72}
        summaryAggregationMode="none"
      />
      <Column
        id="e52a6"
        alignment="left"
        format="tag"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="laborType"
        label="Labor type"
        placeholder="Select option"
        position="center"
        size={87}
        valueOverride="{{ _.startCase(item) }}"
      />
      <Column
        id="f5070"
        alignment="left"
        cellTooltipMode="overflow"
        format="json"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="groupedShifts"
        label="Grouped shifts"
        placeholder="Enter value"
        position="center"
        size={105}
      />
      <Column
        id="25058"
        alignment="left"
        editableOptions={{ spellCheck: false }}
        format="string"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="true"
        key="userId"
        label="User ID"
        placeholder="Enter value"
        position="center"
        size={82}
      />
      <Column
        id="ad1d8"
        alignment="left"
        editable="false"
        editableOptions={{ spellCheck: false }}
        format="string"
        groupAggregationMode="none"
        hidden="true"
        key="shiftId"
        label="Shift ID"
        placeholder="Enter value"
        position="center"
        size={105}
      />
      <Column
        id="56453"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="true"
        key="timesWorkedPerDay"
        label="Times worked per day"
        placeholder="Enter value"
        position="center"
        size={52}
      />
      <Column
        id="196ea"
        alignment="left"
        editableOptions={{ spellCheck: false }}
        format="string"
        groupAggregationMode="none"
        key="shift_team"
        label="Shift team"
        placeholder="Enter value"
        position="center"
        size={116}
      />
      <Column
        id="19746"
        alignment="left"
        editableOptions={{ spellCheck: false }}
        format="string"
        groupAggregationMode="none"
        key="name"
        label="Name"
        placeholder="Enter value"
        position="center"
        size={106}
      />
      <Column
        id="9f506"
        alignment="left"
        editableOptions={{ spellCheck: false }}
        format="string"
        groupAggregationMode="none"
        key="captain"
        label="Captain"
        placeholder="Enter value"
        position="center"
        size={100}
      />
      <ToolbarButton
        id="1a"
        icon="bold/interface-text-formatting-filter-2"
        label="Filter"
        type="filter"
      />
      <ToolbarButton
        id="3c"
        icon="bold/interface-download-button-2"
        label="Download"
        type="custom"
      >
        <Event
          id="84471066"
          event="clickToolbar"
          method="exportData"
          pluginId="labor_data"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
      <ToolbarButton
        id="4d"
        icon="bold/interface-arrows-round-left"
        label="Refresh"
        type="custom"
      >
        <Event
          id="611e9115"
          event="clickToolbar"
          method="refresh"
          pluginId="labor_data"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
    </Table>
    <Table
      id="hunkware_rev"
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ getRevenue.data }}"
      defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
      emptyMessage="No rows found"
      enableSaveActions={true}
      hidden="true"
      showBorder={true}
      showFooter={true}
      showHeader={true}
      showSummaryRow={true}
      toolbarPosition="bottom"
    >
      <Column
        id="f73a4"
        alignment="left"
        editable="false"
        editableOptions={{ spellCheck: false }}
        format="string"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="Job ID"
        label="Job id"
        placeholder="Enter value"
        position="center"
        size={73.88333129882812}
        summaryAggregationMode="none"
      />
      <Column
        id="687db"
        alignment="left"
        format="date"
        groupAggregationMode="none"
        key="Job Date"
        label="Job date"
        placeholder="Enter value"
        position="center"
        size={83.23333740234375}
        summaryAggregationMode="none"
      />
      <Column
        id="d0b21"
        alignment="left"
        editableOptions={{ spellCheck: false }}
        format="string"
        groupAggregationMode="none"
        key="First Name"
        label="First name"
        placeholder="Enter value"
        position="center"
        size={75.56666564941406}
        summaryAggregationMode="none"
      />
      <Column
        id="4f75a"
        alignment="left"
        editableOptions={{ spellCheck: false }}
        format="string"
        groupAggregationMode="none"
        key="Last Name"
        label="Last name"
        placeholder="Enter value"
        position="center"
        size={87.63333129882812}
        summaryAggregationMode="none"
      />
      <Column
        id="2b088"
        alignment="left"
        editableOptions={{ spellCheck: false }}
        format="string"
        groupAggregationMode="none"
        key="Address"
        label="Address"
        placeholder="Enter value"
        position="center"
        size={172.51666259765625}
        summaryAggregationMode="none"
      />
      <Column
        id="9246f"
        alignment="left"
        format="tag"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="Destination State/Prov"
        label="Destination state prov"
        placeholder="Select option"
        position="center"
        size={140.89999389648438}
        summaryAggregationMode="none"
        valueOverride="{{ _.startCase(item) }}"
      />
      <Column
        id="11eee"
        alignment="left"
        format="tag"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="Category"
        label="Category"
        placeholder="Select option"
        position="center"
        size={110.44999694824219}
        summaryAggregationMode="none"
        valueOverride="{{ _.startCase(item) }}"
      />
      <Column
        id="4a365"
        alignment="left"
        format="tag"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="Status"
        label="Status"
        placeholder="Select option"
        position="center"
        size={71.44999694824219}
        summaryAggregationMode="none"
        valueOverride="{{ _.startCase(item) }}"
      />
      <Column
        id="f4621"
        alignment="left"
        editableOptions={{ spellCheck: false }}
        format="string"
        groupAggregationMode="none"
        key="Grand Total"
        label="Grand total"
        placeholder="Enter value"
        position="center"
        size={79.44999694824219}
        summaryAggregationMode="none"
      />
      <Column
        id="5fd21"
        alignment="left"
        format="tag"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="Captain Name"
        label="Captain name"
        placeholder="Select option"
        position="center"
        size={132.68333435058594}
        summaryAggregationMode="none"
        valueOverride="{{ _.startCase(item) }}"
      />
      <Column
        id="59894"
        alignment="left"
        editableOptions={{ spellCheck: false }}
        format="string"
        groupAggregationMode="none"
        key="Created By"
        label="Created by"
        placeholder="Enter value"
        position="center"
        size={139.96665954589844}
        summaryAggregationMode="none"
      />
      <Column
        id="7f8f0"
        alignment="left"
        format="datetime"
        groupAggregationMode="none"
        key="Created Date"
        label="Created date"
        placeholder="Enter value"
        position="center"
        size={149.26666259765625}
        summaryAggregationMode="none"
      />
      <Column
        id="80831"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="grand_total_numeric"
        label="Grand total numeric"
        placeholder="Enter value"
        position="center"
        size={128.25}
        summaryAggregationMode="sum"
      />
      <ToolbarButton
        id="1a"
        icon="bold/interface-text-formatting-filter-2"
        label="Filter"
        type="filter"
      />
      <ToolbarButton
        id="3c"
        icon="bold/interface-download-button-2"
        label="Download"
        type="custom"
      >
        <Event
          id="485f9373"
          event="clickToolbar"
          method="exportData"
          pluginId="hunkware_rev"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
      <ToolbarButton
        id="4d"
        icon="bold/interface-arrows-round-left"
        label="Refresh"
        type="custom"
      >
        <Event
          id="586f6f10"
          event="clickToolbar"
          method="refresh"
          pluginId="hunkware_rev"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
    </Table>
    <Table
      id="totals_by_captain_by_date"
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ getTotalsByCaptainByDay.data }}"
      defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
      emptyMessage="No rows found"
      enableSaveActions={true}
      hidden="true"
      showBorder={true}
      showFooter={true}
      showHeader={true}
      toolbarPosition="bottom"
    >
      <Column
        id="c45b9"
        alignment="left"
        format="date"
        groupAggregationMode="none"
        key="date"
        label="Date"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="2109b"
        alignment="left"
        format="tag"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="captain"
        label="Captain"
        placeholder="Select option"
        position="center"
        size={100}
        summaryAggregationMode="none"
        valueOverride="{{ _.startCase(item) }}"
      />
      <Column
        id="448f0"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="currency"
        formatOptions={{
          currency: "USD",
          currencySign: "standard",
          notation: "standard",
          showSeparators: true,
          currencyDisplay: "symbol",
        }}
        groupAggregationMode="sum"
        key="move_labor"
        label="Move labor"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="d311a"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="currency"
        formatOptions={{
          currency: "USD",
          currencySign: "standard",
          notation: "standard",
          showSeparators: true,
          currencyDisplay: "symbol",
        }}
        groupAggregationMode="sum"
        key="move_revenue"
        label="Move revenue"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="4999e"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="average"
        key="move_labor_pct"
        label="Move labor pct"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="9976f"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="move_jobs"
        label="Move jobs"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="3139e"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="currency"
        formatOptions={{
          currency: "USD",
          currencySign: "standard",
          notation: "standard",
          showSeparators: true,
          currencyDisplay: "symbol",
        }}
        groupAggregationMode="sum"
        key="junk_labor"
        label="Junk labor"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="37979"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="currency"
        formatOptions={{
          currency: "USD",
          currencySign: "standard",
          notation: "standard",
          showSeparators: true,
          currencyDisplay: "symbol",
        }}
        groupAggregationMode="sum"
        key="junk_revenue"
        label="Junk revenue"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="0c243"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="average"
        key="junk_labor_pct"
        label="Junk labor pct"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="28099"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="junk_jobs"
        label="Junk jobs"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="563f2"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="currency"
        formatOptions={{
          currency: "USD",
          currencySign: "standard",
          notation: "standard",
          showSeparators: true,
          currencyDisplay: "symbol",
        }}
        groupAggregationMode="sum"
        key="overall_labor"
        label="Overall labor"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="6f6ff"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="currency"
        formatOptions={{
          currency: "USD",
          currencySign: "standard",
          notation: "standard",
          showSeparators: true,
          currencyDisplay: "symbol",
        }}
        groupAggregationMode="sum"
        key="overall_revenue"
        label="Overall revenue"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="2fda1"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="average"
        key="overall_labor_pct"
        label="Overall labor pct"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="f7aa0"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="overall_jobs"
        label="Overall jobs"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <ToolbarButton
        id="1a"
        icon="bold/interface-text-formatting-filter-2"
        label="Filter"
        type="filter"
      />
      <ToolbarButton
        id="3c"
        icon="bold/interface-download-button-2"
        label="Download"
        type="custom"
      >
        <Event
          id="9d3dbe20"
          event="clickToolbar"
          method="exportData"
          pluginId="totals_by_captain_by_date"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
      <ToolbarButton
        id="4d"
        icon="bold/interface-arrows-round-left"
        label="Refresh"
        type="custom"
      >
        <Event
          id="6c859545"
          event="clickToolbar"
          method="refresh"
          pluginId="totals_by_captain_by_date"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
    </Table>
    <Text id="text11" value="#### Shift Discrepancies" verticalAlign="center" />
    <Table
      id="shift_discrepanciesTable"
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ getShiftTimeDiscrepancies.data }}"
      defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
      emptyMessage="No rows found"
      enableSaveActions={true}
      rowBackgroundColor="{{ currentRow.group_index % 2 === 0 ? '#ededed' : 'transparent' }}"
      showBorder={true}
      showFooter={true}
      showHeader={true}
      style={{}}
      toolbarPosition="bottom"
    >
      <Column
        id="398ed"
        alignment="left"
        format="date"
        groupAggregationMode="none"
        key="date"
        label="Date"
        placeholder="Enter value"
        position="center"
        size={117.23333740234375}
        summaryAggregationMode="none"
      />
      <Column
        id="7e770"
        alignment="left"
        editable={false}
        editableOptions={{ spellCheck: false }}
        format="string"
        groupAggregationMode="none"
        key="shift_team"
        label="Shift Team"
        placeholder="Enter value"
        position="center"
        size={508.6166687011719}
        summaryAggregationMode="none"
      />
      <Column
        id="da701"
        alignment="left"
        format="tag"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="truck"
        label="Truck"
        placeholder="Select option"
        position="center"
        size={67.58332824707031}
        summaryAggregationMode="none"
        valueOverride="{{ _.startCase(item) }}"
      />
      <Column
        id="2e6d0"
        alignment="left"
        format="tag"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="job_title"
        label="Job Title"
        placeholder="Select option"
        position="center"
        size={119.18333435058594}
        summaryAggregationMode="none"
        valueOverride="{{ _.startCase(item) }}"
      />
      <Column
        id="a0ead"
        alignment="left"
        editableOptions={{ spellCheck: false }}
        format="string"
        groupAggregationMode="none"
        key="name"
        label="Name"
        placeholder="Enter value"
        position="center"
        size={132.13333129882812}
        summaryAggregationMode="none"
      />
      <Column
        id="25aed"
        alignment="left"
        editableOptions={{ spellCheck: false }}
        format="string"
        groupAggregationMode="none"
        hidden="true"
        key="captain"
        label="Captain"
        placeholder="Enter value"
        position="center"
        size={127}
        summaryAggregationMode="none"
      />
      <Column
        id="c7ef1"
        alignment="left"
        format="time"
        groupAggregationMode="none"
        key="start_time"
        label="Start Time"
        placeholder="Enter value"
        position="center"
        size={79.05000305175781}
        summaryAggregationMode="none"
      />
      <Column
        id="6a29c"
        alignment="left"
        format="time"
        groupAggregationMode="none"
        key="end_time"
        label="End Time"
        placeholder="Enter value"
        position="center"
        size={76.53334045410156}
        summaryAggregationMode="none"
      />
      <Column
        id="abf0b"
        alignment="left"
        editableOptions={{ spellCheck: false }}
        format="string"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="Shift Hours"
        label="Shift hours"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="be2b0"
        alignment="left"
        format="time"
        groupAggregationMode="none"
        hidden="true"
        key="median_end_time"
        label="Median end time"
        placeholder="Enter value"
        position="center"
        size={110.58332824707031}
        summaryAggregationMode="none"
      />
      <Column
        id="15e09"
        alignment="left"
        backgroundColor={
          '{{ compareAgainstCaptain.value ? currentSourceRow.captain_start_deviates ? "#991818" : "" : currentSourceRow.start_deviates ? "#991818" : ""}}'
        }
        editableOptions={{ spellCheck: false }}
        format="string"
        groupAggregationMode="none"
        hidden="{{ compareAgainstCaptain.value }}"
        key="start_deviation"
        label="Start deviation"
        placeholder="Enter value"
        position="center"
        size={109.35000610351562}
        summaryAggregationMode="none"
        valueOverride="{{ currentSourceRow.start_deviates ? item : null }}"
      />
      <Column
        id="a4f2d"
        alignment="left"
        backgroundColor={
          '{{ compareAgainstCaptain.value ? currentSourceRow.captain_end_deviates ? "#991818" : "" : currentSourceRow.end_deviates ? "#991818" : ""}}'
        }
        editableOptions={{ spellCheck: false }}
        format="string"
        groupAggregationMode="none"
        hidden="{{ compareAgainstCaptain.value }}"
        key="end_deviation"
        label="End deviation"
        placeholder="Enter value"
        position="center"
        size={102.39999389648438}
        summaryAggregationMode="none"
        valueOverride="{{ currentSourceRow.end_deviates ? item : null }}"
      />
      <Column
        id="9b38a"
        alignment="left"
        format="boolean"
        groupAggregationMode="none"
        hidden="true"
        key="start_deviates"
        label="Start deviates"
        placeholder="Enter value"
        position="center"
        size={95.5}
        summaryAggregationMode="none"
      />
      <Column
        id="214c0"
        alignment="left"
        format="boolean"
        groupAggregationMode="none"
        hidden="true"
        key="end_deviates"
        label="End deviates"
        placeholder="Enter value"
        position="center"
        size={89.11666870117188}
        summaryAggregationMode="none"
      />
      <Column
        id="b9444"
        alignment="left"
        format="time"
        groupAggregationMode="none"
        hidden="true"
        key="median_start_time"
        label="Median start time"
        placeholder="Enter value"
        position="center"
        size={0}
        summaryAggregationMode="none"
      />
      <Column
        id="ef7ff"
        alignment="left"
        backgroundColor={
          '{{ compareAgainstCaptain.value ? currentSourceRow.captain_start_deviates ? "#991818" : "" : currentSourceRow.start_deviates ? "#991818" : ""}}'
        }
        editableOptions={{ spellCheck: false }}
        format="string"
        groupAggregationMode="none"
        hidden="{{ !compareAgainstCaptain.value }}"
        key="captain_start_deviation"
        label="Captain start deviation"
        placeholder="Enter value"
        position="center"
        size={119}
        summaryAggregationMode="none"
      />
      <Column
        id="1fb82"
        alignment="left"
        backgroundColor={
          '{{ compareAgainstCaptain.value ? currentSourceRow.captain_end_deviates ? "#991818" : "" : currentSourceRow.end_deviates ? "#991818" : ""}}'
        }
        editableOptions={{ spellCheck: false }}
        format="string"
        groupAggregationMode="none"
        hidden="{{ !compareAgainstCaptain.value }}"
        key="captain_end_deviation"
        label="Captain end deviation"
        placeholder="Enter value"
        position="center"
        size={101}
        summaryAggregationMode="none"
      />
      <Column
        id="01a20"
        alignment="left"
        format="boolean"
        groupAggregationMode="none"
        hidden="true"
        key="captain_start_deviates"
        label="Captain start deviates"
        placeholder="Enter value"
        position="center"
        size={65}
        summaryAggregationMode="none"
      />
      <Column
        id="fdcd5"
        alignment="left"
        format="boolean"
        groupAggregationMode="none"
        hidden="true"
        key="captain_end_deviates"
        label="Captain end deviates"
        placeholder="Enter value"
        position="center"
        size={30}
        summaryAggregationMode="none"
      />
      <Column
        id="d990a"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="true"
        key="group_index"
        label="Group index"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <ToolbarButton
        id="d790c"
        icon="bold/interface-remove-circle"
        label="Only show discrepancies"
        type="custom"
      >
        <Event
          id="acbc0ff5"
          event="clickToolbar"
          method="run"
          params={{
            map: {
              src: 'const newVal = !showOnlyDiscrepancies.value;\nshowOnlyDiscrepancies.setValue(newVal);\n\nif (newVal == true) {\n  if (compareAgainstCaptain.value == true) {\n      shift_discrepanciesTable.setFilterStack({\n        filters: [{\n            filters: [{\n                columnId: "captain_start_deviates",\n                operator: "isTrue"\n            }, {\n                columnId: "captain_end_deviates",\n                operator: "isTrue"\n            }],\n            operator: \'or\'\n        }]\n    })\n  } else {\n    shift_discrepanciesTable.setFilterStack({\n        filters: [{\n            filters: [{\n                columnId: "start_deviates",\n                operator: "isTrue"\n            }, {\n                columnId: "end_deviates",\n                operator: "isTrue"\n            }],\n            operator: \'or\'\n        }]\n    })\n  }\n} else {\n  shift_discrepanciesTable.clearFilterStack()\n}',
            },
          }}
          pluginId=""
          type="script"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
      <ToolbarButton
        id="7a417"
        icon="bold/interface-user-single"
        label="Compare against Captain"
        type="custom"
      >
        <Event
          id="a8f98379"
          event="clickToolbar"
          method="setValue"
          params={{ map: { value: "{{ !compareAgainstCaptain.value }}" } }}
          pluginId="compareAgainstCaptain"
          type="state"
          waitMs="0"
          waitType="debounce"
        />
        <Event
          id="43d670d9"
          event="clickToolbar"
          method="run"
          params={{
            map: {
              src: 'if (showOnlyDiscrepancies.value == true && compareAgainstCaptain.value == true) {\n    shift_discrepanciesTable.setFilterStack({\n      filters: [{\n          filters: [{\n              columnId: "captain_start_deviates",\n              operator: "isTrue"\n          }, {\n              columnId: "captain_end_deviates",\n              operator: "isTrue"\n          }],\n          operator: \'or\'\n      }]\n  })\n} else if (showOnlyDiscrepancies.value == true && compareAgainstCaptain.value == false) {\n    shift_discrepanciesTable.setFilterStack({\n      filters: [{\n          filters: [{\n              columnId: "start_deviates",\n              operator: "isTrue"\n          }, {\n              columnId: "end_deviates",\n              operator: "isTrue"\n          }],\n          operator: \'or\'\n      }]\n  })\n}',
            },
          }}
          pluginId=""
          type="script"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
      <ToolbarButton
        id="1a"
        icon="bold/interface-text-formatting-filter-2"
        label="Filter"
        type="filter"
      />
      <ToolbarButton
        id="3c"
        icon="bold/interface-download-button-2"
        label="Download"
        type="custom"
      >
        <Event
          id="d8d7a39c"
          event="clickToolbar"
          method="exportData"
          pluginId="shift_discrepanciesTable"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
      <ToolbarButton
        id="4d"
        icon="bold/interface-arrows-round-left"
        label="Refresh"
        type="custom"
      >
        <Event
          id="3769002f"
          event="clickToolbar"
          method="refresh"
          pluginId="shift_discrepanciesTable"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
      <ToolbarButton
        id="540c2"
        icon="bold/interface-text-formatting-list-bullets"
        label="Group by"
        type="groupBy"
      />
    </Table>
    <Text
      id="text20"
      value="#### Labor % By Crew Size"
      verticalAlign="center"
    />
    <Table
      id="laborPctByCrewSize_table"
      autoColumnWidth={true}
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ laborPctByCrewSize.data }}"
      defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
      emptyMessage="No rows found"
      enableSaveActions={true}
      heightType="auto"
      showBorder={true}
      showFooter={true}
      showHeader={true}
      showSummaryRow={true}
      toolbarPosition="bottom"
    >
      <Column
        id="a096d"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="person_count"
        label="Crew Size"
        placeholder="Enter value"
        position="center"
        size={72.89999389648438}
      />
      <Column
        id="efd8e"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="number_of_jobs"
        label="Jobs"
        placeholder="Enter value"
        position="center"
        size={43.399993896484375}
        summaryAggregationMode="sum"
      />
      <Column
        id="978d3"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="true"
        key="jobs_with_revenue"
        label="Jobs with revenue"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="sum"
      />
      <Column
        id="36eb8"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="currency"
        formatOptions={{
          currency: "USD",
          currencySign: "standard",
          notation: "standard",
          showSeparators: true,
          currencyDisplay: "symbol",
        }}
        groupAggregationMode="sum"
        key="total_labor"
        label="Labor"
        placeholder="Enter value"
        position="center"
        size={74.48333740234375}
        summaryAggregationMode="sum"
      />
      <Column
        id="598a7"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="currency"
        formatOptions={{
          currency: "USD",
          currencySign: "standard",
          notation: "standard",
          showSeparators: true,
          currencyDisplay: "symbol",
        }}
        groupAggregationMode="sum"
        key="total_revenue"
        label="Revenue"
        placeholder="Enter value"
        position="center"
        size={79.36666870117188}
        summaryAggregationMode="sum"
      />
      <Column
        id="42363"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="average"
        key="labor %"
        label="Labor %"
        placeholder="Enter value"
        position="center"
        size={61.73333740234375}
      />
      <ToolbarButton
        id="1a"
        icon="bold/interface-text-formatting-filter-2"
        label="Filter"
        type="filter"
      />
      <ToolbarButton
        id="3c"
        icon="bold/interface-download-button-2"
        label="Download"
        type="custom"
      >
        <Event
          id="18ce5bf4"
          event="clickToolbar"
          method="exportData"
          pluginId="laborPctByCrewSize_table"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
      <ToolbarButton
        id="4d"
        icon="bold/interface-arrows-round-left"
        label="Refresh"
        type="custom"
      >
        <Event
          id="954873fe"
          event="clickToolbar"
          method="refresh"
          pluginId="laborPctByCrewSize_table"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
    </Table>
  </Frame>
</Screen>
