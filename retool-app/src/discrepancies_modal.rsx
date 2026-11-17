<ModalFrame
  id="discrepancies_modal"
  footerPadding="8px 12px"
  headerPadding="8px 12px"
  hidden={true}
  hideOnEscape={true}
  isHiddenOnMobile={true}
  overlayInteraction={true}
  padding="8px 12px"
  showHeader="true"
  showOverlay={true}
  size="fullScreen"
>
  <Header>
    <Button
      id="modalCloseButton2"
      ariaLabel="Close"
      horizontalAlign="right"
      iconBefore="bold/interface-delete-1"
      style={{ map: { border: "transparent" } }}
      styleVariant="outline"
    >
      <Event
        id="7ade719e"
        event="click"
        method="setHidden"
        params={{ map: { hidden: true } }}
        pluginId="discrepancies_modal"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
    </Button>
  </Header>
  <Body>
    <Text
      id="text10"
      value="### Unmatched Hunkware IDs: {{ unmatchedHunkwareIDs.value.length }}"
      verticalAlign="center"
    />
    <Table
      id="unmatched_hunkware_ids_table"
      actionsOverflowPosition={1}
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ discrepancies_table.value }}"
      defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
      defaultSort={[
        { object: { columnId: "94b93", direction: "asc" } },
        { object: { columnId: "96028", direction: "asc" } },
      ]}
      emptyMessage="No rows found"
      enableSaveActions={true}
      heightType="auto"
      primaryKeyColumnId="2f953"
      showBorder={true}
      showFooter={true}
      showHeader={true}
      toolbarPosition="bottom"
    >
      <Column
        id="2e582"
        alignment="left"
        editableOptions={{ spellCheck: false }}
        format="string"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="hunkware_id"
        label="Hunkware ID"
        placeholder="Enter value"
        position="center"
        size={329}
        summaryAggregationMode="none"
      />
      <Column
        id="96028"
        alignment="left"
        format="date"
        groupAggregationMode="none"
        key="date"
        label="Date"
        placeholder="Enter value"
        position="center"
        size={102}
        summaryAggregationMode="none"
      />
      <Column
        id="b161b"
        alignment="left"
        editableOptions={{ spellCheck: false }}
        format="string"
        groupAggregationMode="none"
        key="shift_team"
        label="Shift team"
        placeholder="Enter value"
        position="center"
        size={434}
        summaryAggregationMode="none"
      />
      <Column
        id="3adb1"
        alignment="left"
        format="tag"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="laborType"
        label="Labor type"
        placeholder="Select option"
        position="center"
        size={100}
        summaryAggregationMode="none"
        valueOverride="{{ _.startCase(item) }}"
      />
      <Column
        id="33634"
        alignment="left"
        editableOptions={{ spellCheck: false }}
        format="string"
        groupAggregationMode="none"
        key="reason"
        label="Reason"
        placeholder="Enter value"
        position="center"
        size={255}
        summaryAggregationMode="none"
      />
      <Column
        id="21c54"
        alignment="left"
        editable="true"
        format="boolean"
        groupAggregationMode="none"
        key="fixed"
        label="Fixed"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="0a5fa"
        alignment="left"
        editable="true"
        editableOptions={{ spellCheck: false }}
        format="string"
        groupAggregationMode="none"
        key="notes"
        label="Notes"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="2f953"
        alignment="right"
        editable="false"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="true"
        key="_rowId"
        label="Row ID"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Action
        id="fb6ca"
        disabled="{{ getUnmatchedHunkwareIDs.isFetching }}"
        icon="bold/interface-delete-2"
        label="Delete Shift"
      >
        <Event
          id="6e03143e"
          event="clickAction"
          method="trigger"
          params={{
            map: {
              options: {
                map: {
                  additionalScope: {
                    id: "{{ currentSourceRow.hunkware_id }}",
                    date: "{{ currentSourceRow.date }}",
                    shift_team: "{{ currentSourceRow.shift_team }}",
                  },
                },
              },
            },
          }}
          pluginId="deleteShift"
          type="datasource"
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
          id="30c554dc"
          event="clickToolbar"
          method="exportData"
          pluginId="unmatched_hunkware_ids_table"
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
          id="6b725919"
          event="clickToolbar"
          method="refresh"
          pluginId="unmatched_hunkware_ids_table"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
      <Event
        id="99145131"
        event="save"
        method="run"
        params={{
          map: {
            src: "let data = _.cloneDeep(discrepancies_table.value);\nlet rowCount = data.hunkware_id.length;\n\ndata._rowId = _.range(rowCount);\ndata.fixed = _.map(discrepancies_extra.value, (row, i) => _.get(row, 'fixed', data.fixed?.[i]));\ndata.notes = _.map(discrepancies_extra.value, (row, i) => _.get(row, 'notes', data.notes?.[i]));\n\ndiscrepancies_table.setValue(data);\n\nconst payload = await discrepancies_upsert_to_db.trigger();\nawait update_discrepancies_table.trigger({additionalScope: {payload: payload}});",
          },
        }}
        pluginId=""
        type="script"
        waitMs="0"
        waitType="debounce"
      />
    </Table>
    <Text
      id="text12"
      hidden=""
      value={
        '### Unassigned Captains in Labor: {{ new Set(labor_data.data.filter(r => (r.captain === "" || r.captain === null) && new Date(r.date) >= date_range_start.value && new Date(r.date) <= date_range_end.value && r.laborType === "Junk").map(r => r.shift_team)).size }}'
      }
      verticalAlign="center"
    />
    <Table
      id="unassigned_captains_in_labor_table"
      cellSelection="none"
      clearChangesetOnSave={true}
      data={
        '{{ Array.from(new Map(labor_data.data.filter(r => (r.captain == "" || r.captain == null) && new Date(r.date) >= date_range_start.value && new Date(r.date) <= date_range_end.value && r.laborType === "Junk").map(r => [r.shift_team, r])).values()) }}'
      }
      defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
      defaultSort={[{ object: { columnId: "94b93", direction: "asc" } }]}
      emptyMessage="No rows found"
      enableSaveActions={true}
      heightType="auto"
      hidden=""
      showBorder={true}
      showFooter={true}
      showHeader={true}
      toolbarPosition="bottom"
    >
      <Column
        id="33d96"
        alignment="left"
        editable={false}
        editableOptions={{ spellCheck: false }}
        format="string"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="hunkware_id"
        label="Hunkware ID"
        placeholder="Enter value"
        position="center"
        size={132.35000610351562}
        summaryAggregationMode="none"
      />
      <Column
        id="94b93"
        alignment="left"
        format="date"
        groupAggregationMode="none"
        key="date"
        label="Date"
        placeholder="Enter value"
        position="center"
        size={113.80000305175781}
        summaryAggregationMode="none"
      />
      <Column
        id="f7067"
        alignment="left"
        format="tag"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="laborType"
        label="Labor type"
        placeholder="Select option"
        position="center"
        size={84.33332824707031}
        summaryAggregationMode="none"
        valueOverride="{{ _.startCase(item) }}"
      />
      <Column
        id="a3153"
        alignment="left"
        editableOptions={{ spellCheck: false }}
        format="string"
        groupAggregationMode="none"
        key="shift_team"
        label="Shift team"
        placeholder="Enter value"
        position="center"
        size={363.95001220703125}
        summaryAggregationMode="none"
      />
      <Column
        id="df03e"
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
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="b20f1"
        alignment="left"
        cellTooltipMode="overflow"
        format="tags"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        hidden="true"
        key="groupedShifts"
        label="Grouped shifts"
        placeholder="Select options"
        position="center"
        size={113}
        summaryAggregationMode="none"
      />
      <Column
        id="d5e59"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="true"
        key="userId"
        label="User ID"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="22e02"
        alignment="left"
        editableOptions={{ spellCheck: false }}
        format="string"
        groupAggregationMode="none"
        hidden="true"
        key="shiftId"
        label="Shift ID"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="bfb4c"
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
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="46e7e"
        alignment="left"
        editableOptions={{ spellCheck: false }}
        format="string"
        groupAggregationMode="none"
        key="name"
        label="Name"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="31d10"
        alignment="left"
        editableOptions={{ spellCheck: false }}
        format="string"
        groupAggregationMode="none"
        key="captain"
        label="Captain"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="da49d"
        alignment="left"
        format="tag"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="truck"
        label="Truck"
        placeholder="Select option"
        position="center"
        size={100}
        summaryAggregationMode="none"
        valueOverride="{{ _.startCase(item) }}"
      />
      <Column
        id="13637"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="true"
        key="start_time"
        label="Start time"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="5faec"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="true"
        key="end_time"
        label="End time"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="67018"
        alignment="left"
        format="tag"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="job_title"
        label="Job title"
        placeholder="Select option"
        position="center"
        size={100}
        summaryAggregationMode="none"
        valueOverride="{{ _.startCase(item) }}"
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
          id="30c554dc"
          event="clickToolbar"
          method="exportData"
          pluginId="unassigned_captains_in_labor_table"
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
          id="6b725919"
          event="clickToolbar"
          method="refresh"
          pluginId="unassigned_captains_in_labor_table"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
    </Table>
    <Text
      id="text9"
      value={
        '### Missing Captains: {{ hunkware_rev.data.filter(r => {\n    const jobDate = r["Job Date"];\n    const start = moment(date_range_start.value).format("YYYY-MM-DD");\n    const end = moment(date_range_end.value).format("YYYY-MM-DD");\n    return (r["Captain Name"] === "" || r["Captain Name"] === null) \n      && ["Closed", "Completed"].includes(r.Status) \n      && jobDate >= start \n      && jobDate <= end;\n}).length }}'
      }
      verticalAlign="center"
    />
    <Table
      id="missing_captains_table"
      cellSelection="none"
      clearChangesetOnSave={true}
      data={
        '{{ hunkware_rev.data.filter(r => {\n    const jobDate = r["Job Date"];\n    const start = moment(date_range_start.value).format("YYYY-MM-DD");\n    const end = moment(date_range_end.value).format("YYYY-MM-DD");\n    return (r["Captain Name"] === "" || r["Captain Name"] === null) \n      && ["Closed", "Completed"].includes(r.Status) \n      && jobDate >= start \n      && jobDate <= end;\n}) }}'
      }
      defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
      defaultSort={[{ object: { columnId: "147e0", direction: "asc" } }]}
      emptyMessage="No rows found"
      enableSaveActions={true}
      heightType="auto"
      rowHeight="medium"
      showBorder={true}
      showFooter={true}
      showHeader={true}
      toolbarPosition="bottom"
    >
      <Column
        id="9a305"
        alignment="left"
        editableOptions={{ spellCheck: false }}
        format="string"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="Job ID"
        label="Job id"
        placeholder="Enter value"
        position="center"
        size={83}
        summaryAggregationMode="none"
      />
      <Column
        id="147e0"
        alignment="left"
        format="date"
        groupAggregationMode="none"
        key="Job Date"
        label="Job date"
        placeholder="Enter value"
        position="center"
        size={113}
        summaryAggregationMode="none"
      />
      <Column
        id="91f0d"
        alignment="left"
        editableOptions={{ spellCheck: false }}
        format="string"
        groupAggregationMode="none"
        key="First Name"
        label="First name"
        placeholder="Enter value"
        position="center"
        size={64}
        summaryAggregationMode="none"
      />
      <Column
        id="f921c"
        alignment="left"
        editableOptions={{ spellCheck: false }}
        format="string"
        groupAggregationMode="none"
        key="Last Name"
        label="Last name"
        placeholder="Enter value"
        position="center"
        size={76}
        summaryAggregationMode="none"
      />
      <Column
        id="7edb4"
        alignment="left"
        editableOptions={{ spellCheck: false }}
        format="string"
        groupAggregationMode="none"
        key="Address"
        label="Address"
        placeholder="Enter value"
        position="center"
        size={62}
        summaryAggregationMode="none"
      />
      <Column
        id="ae3be"
        alignment="left"
        format="tag"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="Destination State/Prov"
        label="Destination state prov"
        placeholder="Select option"
        position="center"
        size={61}
        summaryAggregationMode="none"
        valueOverride="{{ _.startCase(item) }}"
      />
      <Column
        id="b2883"
        alignment="left"
        format="tag"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="Category"
        label="Category"
        placeholder="Select option"
        position="center"
        size={118}
        summaryAggregationMode="none"
        valueOverride="{{ _.startCase(item) }}"
      />
      <Column
        id="b31d9"
        alignment="left"
        format="tag"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="Status"
        label="Status"
        placeholder="Select option"
        position="center"
        size={107}
        summaryAggregationMode="none"
        valueOverride="{{ _.startCase(item) }}"
      />
      <Column
        id="8235a"
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
        key="Grand Total"
        label="Grand total"
        placeholder="Enter value"
        position="center"
        size={92}
        summaryAggregationMode="none"
      />
      <Column
        id="db8d0"
        alignment="left"
        editableOptions={{ spellCheck: false }}
        format="string"
        groupAggregationMode="none"
        key="Captain Name"
        label="Captain name"
        placeholder="Enter value"
        position="center"
        size={103}
        summaryAggregationMode="none"
      />
      <Column
        id="93364"
        alignment="left"
        format="tag"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        hidden="true"
        key="Created By"
        label="Created by"
        placeholder="Select option"
        position="center"
        size={0}
        summaryAggregationMode="none"
        valueOverride="{{ _.startCase(item) }}"
      />
      <Column
        id="c7d4e"
        alignment="left"
        format="datetime"
        groupAggregationMode="none"
        hidden="true"
        key="Created Date"
        label="Created date"
        placeholder="Enter value"
        position="center"
        size={0}
        summaryAggregationMode="none"
      />
      <Column
        id="0f392"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="true"
        key="grand_total_numeric"
        label="Grand total numeric"
        placeholder="Enter value"
        position="center"
        size={61}
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
          id="063d2334"
          event="clickToolbar"
          method="exportData"
          pluginId="missing_captains_table"
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
          id="4c10756f"
          event="clickToolbar"
          method="refresh"
          pluginId="missing_captains_table"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
    </Table>
    <Text
      id="missing_shifts_number_text"
      hidden="true"
      value="### Missing Shifts: {{ missing_connecteam_shifts.data.length }}"
      verticalAlign="center"
    />
    <Text
      id="missing_shifts_explain_text"
      hidden="true"
      value="### User has timesheet entry but no matching shift"
      verticalAlign="center"
    />
    <Text
      id="missing_shifts_text"
      hidden="true"
      value={
        "### Missing Pay: {{ new Intl.NumberFormat(\"en-US\", {style: 'currency', currency: 'usd'}).format(_.sumBy(missing_connecteam_shifts.data, 'pay')) }}"
      }
      verticalAlign="center"
    />
    <Table
      id="missing_connecteam_shifts"
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ get_connecteam_timesheet_discrepancies.data.missingFromShifts }}"
      defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
      emptyMessage="No rows found"
      enableSaveActions={true}
      heightType="auto"
      hidden="true"
      showBorder={true}
      showFooter={true}
      showHeader={true}
      showSummaryRow={true}
      toolbarPosition="bottom"
    >
      <Column
        id="db08d"
        alignment="left"
        editableOptions={{ spellCheck: false }}
        format="string"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="userId"
        label="User ID"
        placeholder="Enter value"
        position="center"
        size={131}
        summaryAggregationMode="none"
        valueOverride="{{ get_users.data.full_name[get_users.data.user_id.findIndex(u => u == item)] }}"
      />
      <Column
        id="0f3b5"
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
        id="8408e"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="hours"
        label="Hours"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="sum"
      />
      <Column
        id="8eb38"
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
        key="pay"
        label="Pay"
        placeholder="Enter value"
        position="center"
        size={108}
        summaryAggregationMode="sum"
      />
      <Column
        id="d3ad2"
        alignment="left"
        format="boolean"
        groupAggregationMode="none"
        key="hasRate"
        label="Has pay rate"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="0de4e"
        alignment="left"
        editableOptions={{ spellCheck: false }}
        format="string"
        groupAggregationMode="none"
        hidden="true"
        key="key"
        label="Key"
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
          id="1858d2ca"
          event="clickToolbar"
          method="exportData"
          pluginId="missing_connecteam_shifts"
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
          id="10603146"
          event="clickToolbar"
          method="refresh"
          pluginId="missing_connecteam_shifts"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
    </Table>
    <Text
      id="text18"
      value="### Missing Shift Layers: {{ missing_connecteam_shift_layers.data.length }}"
      verticalAlign="center"
    />
    <Table
      id="missing_connecteam_shift_layers"
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ get_connecteam_timesheet_discrepancies.data.emptyLayerShifts }}"
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
        id="db08d"
        alignment="left"
        editableOptions={{ spellCheck: false }}
        format="string"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="userId"
        label="User ID"
        placeholder="Enter value"
        position="center"
        size={131}
        summaryAggregationMode="none"
        valueOverride="{{ get_users.data.full_name[get_users.data.user_id.findIndex(u => u == item)] }}"
      />
      <Column
        id="0f3b5"
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
        id="255af"
        alignment="left"
        editableOptions={{ spellCheck: false }}
        format="string"
        groupAggregationMode="none"
        key="title"
        label="Job Title"
        placeholder="Enter value"
        position="center"
        referenceId="title"
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
          id="1858d2ca"
          event="clickToolbar"
          method="exportData"
          pluginId="missing_connecteam_shift_layers"
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
          id="10603146"
          event="clickToolbar"
          method="refresh"
          pluginId="missing_connecteam_shift_layers"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
    </Table>
    <Text
      id="text17"
      value="### User has shift entry but no matching timesheet data"
      verticalAlign="center"
    />
    <Text
      id="text15"
      heightType="fixed"
      value="### Missing Clock Ins: {{ missing_connecteam_clock_ins.data.length }}"
      verticalAlign="center"
    />
    <Table
      id="missing_connecteam_clock_ins"
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ get_connecteam_timesheet_discrepancies.data.noTimesheet }}"
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
        id="db08d"
        alignment="left"
        editableOptions={{ spellCheck: false }}
        format="string"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="userId"
        label="User ID"
        placeholder="Enter value"
        position="center"
        size={180}
        summaryAggregationMode="none"
        valueOverride="{{ get_users.data.full_name[get_users.data.user_id.findIndex(u => u == item)] }}"
      />
      <Column
        id="0f3b5"
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
          id="1858d2ca"
          event="clickToolbar"
          method="exportData"
          pluginId="missing_connecteam_clock_ins"
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
          id="10603146"
          event="clickToolbar"
          method="refresh"
          pluginId="missing_connecteam_clock_ins"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
    </Table>
  </Body>
</ModalFrame>
