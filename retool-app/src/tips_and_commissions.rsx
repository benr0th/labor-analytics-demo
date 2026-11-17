<Screen
  id="tips_and_commissions"
  _customShortcuts={[]}
  _hashParams={[]}
  _order={1}
  _searchParams={[]}
  browserTitle={null}
  title="Tips and Commissions"
  urlSlug={null}
  uuid="393707e4-fded-4c5f-a16a-aa22d3a8d900"
>
  <Folder id="vars">
    <State id="squareValues" />
    <State id="tips_junk_total_labor" />
    <State id="tips_bonus_goal" />
    <State id="tips_junk_total_rev" />
    <State id="squareNotes" />
    <State id="tips_sort_by_date" value="false" />
  </Folder>
  <Folder id="transformers">
    <Function
      id="square_dates"
      funcBody={include("../lib/square_dates.js", "string")}
    />
    <Function
      id="tips_bonus_transformer"
      funcBody={include("../lib/tips_bonus_transformer.js", "string")}
    />
    <Function
      id="tips_adj_bonus_threshold"
      funcBody={include("../lib/tips_adj_bonus_threshold.js", "string")}
    />
    <Function
      id="tips_date_end"
      funcBody={include("../lib/tips_date_end.js", "string")}
    />
    <Function
      id="tips_date_start"
      funcBody={include("../lib/tips_date_start.js", "string")}
    />
    <Function
      id="map_bonuses_to_captains"
      funcBody={include("../lib/map_bonuses_to_captains.js", "string")}
    />
    <Function
      id="daily_tip_total"
      funcBody={include("../lib/daily_tip_total.js", "string")}
    />
    <Function
      id="square_transformer"
      funcBody={include("../lib/square_transformer.js", "string")}
    />
    <Function
      id="update_square_indexes"
      funcBody={include("../lib/update_square_indexes.js", "string")}
    />
    <Function
      id="update_square_values"
      funcBody={include("../lib/update_square_values.js", "string")}
    />
    <Function
      id="update_square_notes"
      funcBody={include("../lib/update_square_notes.js", "string")}
    />
    <Function
      id="square_notes_transformer"
      funcBody={include("../lib/square_notes_transformer.js", "string")}
    />
    <Function
      id="update_tips_table_transformer"
      funcBody={include("../lib/update_tips_table_transformer.js", "string")}
    />
  </Folder>
  <Folder id="setters">
    <SqlQueryUnified
      id="tips_formSubmitHandler"
      actionType="UPDATE_OR_INSERT_BY"
      changeset={
        '[{"key":"tip","value":"{{ form_tip.value }}"},{"key":"commission","value":"{{ form_commission.value }}"},{"key":"deductions","value":"{{ form_deductions.value }}"},{"key":"deduction_reason","value":"{{ form_deduction_reason.value }}"},{"key":"name","value":"{{ form_name.value }}"},{"key":"date","value":"{{ moment(form_date.value) }}"},{"key":"out_of_state_pay","value":"{{ form_out_of_state.value }}"}]'
      }
      filterBy={
        '[{"key":"date","value":"{{ form_date.value }}","operation":"="},{"key":"name","value":"{{ form_name.value }}","operation":"="}]'
      }
      notificationDuration={4.5}
      query={include("../lib/tips_formSubmitHandler.sql", "string")}
      resourceDisplayName="Supabase - Demo"
      resourceName="b4731250-4b92-46f4-a6f7-45cca5606d79"
      resourceTypeOverride=""
      runWhenModelUpdates={false}
      showSuccessToaster={false}
      tableName="tips_and_commissions"
      warningCodes={[]}
    >
      <Event
        id="13d07bea"
        event="success"
        method="trigger"
        params={{}}
        pluginId="getTipsCommsData"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        id="4b6ee54f"
        event="success"
        method="clearValue"
        params={{}}
        pluginId="form_tip"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        id="4b6ee54f"
        event="success"
        method="clearValue"
        params={{}}
        pluginId="form_commission"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        id="4b6ee54f"
        event="success"
        method="clearValue"
        params={{}}
        pluginId="form_deductions"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        id="4b6ee54f"
        event="success"
        method="clearValue"
        params={{}}
        pluginId="form_out_of_state"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
    </SqlQueryUnified>
    <SqlQueryUnified
      id="set_tips_last_selected_pay_period"
      query={include("../lib/set_tips_last_selected_pay_period.sql", "string")}
      resourceDisplayName="Supabase - Demo"
      resourceName="b4731250-4b92-46f4-a6f7-45cca5606d79"
      resourceTypeOverride=""
      runWhenModelUpdates={false}
      showSuccessToaster={false}
      warningCodes={[]}
    />
  </Folder>
  <Folder id="getters">
    <SqlQueryUnified
      id="tips_get_bonus_goal"
      notificationDuration={4.5}
      query={include("../lib/tips_get_bonus_goal.sql", "string")}
      resourceDisplayName="Supabase - Demo"
      resourceName="b4731250-4b92-46f4-a6f7-45cca5606d79"
      resourceTypeOverride=""
      showSuccessToaster={false}
      showUpdateSetValueDynamicallyToggle={false}
      updateSetValueDynamically={true}
      warningCodes={[]}
    >
      <Event
        id="7c8791ee"
        event="success"
        method="setValue"
        params={{ map: { value: "{{ self.data.value[0] }}" } }}
        pluginId="tips_bonus_goal"
        type="state"
        waitMs="0"
        waitType="debounce"
      />
    </SqlQueryUnified>
    <SqlQueryUnified
      id="get_tips_last_selected_pay_period"
      isMultiplayerEdited={false}
      query={include("../lib/get_tips_last_selected_pay_period.sql", "string")}
      resourceDisplayName="Supabase - Demo"
      resourceName="b4731250-4b92-46f4-a6f7-45cca5606d79"
      resourceTypeOverride=""
      warningCodes={[]}
    >
      <Event
        id="37a2c765"
        event="success"
        method="run"
        params={{
          map: {
            src: 'await set_tips_pay_period_to_most_recent.trigger({additionalScope: {start: self.data.value[0].split("-")[0].replaceAll(\'"\', "")}})\n\nawait tips_set_date_filterStack.trigger()\n\nawait get_tips_from_square.trigger()',
          },
        }}
        pluginId=""
        type="script"
        waitMs="0"
        waitType="debounce"
      />
    </SqlQueryUnified>
  </Folder>
  <Folder id="js_functions">
    <JavascriptQuery
      id="tips_set_date_filterStack"
      notificationDuration={4.5}
      query={include("../lib/tips_set_date_filterStack.js", "string")}
      resourceName="JavascriptQuery"
      showSuccessToaster={false}
    />
    <JavascriptQuery
      id="set_tips_pay_period_to_most_recent"
      _additionalScope={["start"]}
      notificationDuration={4.5}
      query={include("../lib/set_tips_pay_period_to_most_recent.js", "string")}
      resourceName="JavascriptQuery"
      showSuccessToaster={false}
    />
  </Folder>
  <Folder id="supabase_queries">
    <SqlQueryUnified
      id="tips_getJunkCommissions"
      query={include("../lib/tips_getJunkCommissions.sql", "string")}
      resourceDisplayName="Supabase - Demo"
      resourceName="b4731250-4b92-46f4-a6f7-45cca5606d79"
      resourceTypeOverride=""
      warningCodes={[]}
    />
    <SqlQueryUnified
      id="getJunkTotals"
      isMultiplayerEdited={false}
      query={include("../lib/getJunkTotals.sql", "string")}
      resourceDisplayName="Supabase - Demo"
      resourceName="b4731250-4b92-46f4-a6f7-45cca5606d79"
      resourceTypeOverride=""
      warningCodes={[]}
    >
      <Event
        id="bc45196d"
        event="success"
        method="setValue"
        params={{ map: { value: "{{ _.toNumber(self.data.junk_labor[0]) }}" } }}
        pluginId="tips_junk_total_labor"
        type="state"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        id="bc45196d"
        event="success"
        method="setValue"
        params={{
          map: { value: "{{ _.toNumber(self.data.junk_revenue[0]) }}" },
        }}
        pluginId="tips_junk_total_rev"
        type="state"
        waitMs="0"
        waitType="debounce"
      />
    </SqlQueryUnified>
    <SqlQueryUnified
      id="getDeductionReasons"
      query={include("../lib/getDeductionReasons.sql", "string")}
      resourceDisplayName="Supabase - Demo"
      resourceName="b4731250-4b92-46f4-a6f7-45cca5606d79"
      resourceTypeOverride=""
      warningCodes={[]}
    />
    <SqlQueryUnified
      id="getUsers"
      query={include("../lib/getUsers.sql", "string")}
      resourceDisplayName="Supabase - Demo"
      resourceName="b4731250-4b92-46f4-a6f7-45cca5606d79"
      resourceTypeOverride=""
      warningCodes={[]}
    />
    <SqlQueryUnified
      id="getTipsCommsData"
      query={include("../lib/getTipsCommsData.sql", "string")}
      resourceDisplayName="Supabase - Demo"
      resourceName="b4731250-4b92-46f4-a6f7-45cca5606d79"
      resourceTypeOverride=""
      warningCodes={[]}
    />
    <SqlQueryUnified
      id="update_square_data"
      actionType="UPDATE_BY"
      changeset="[]"
      changesetObject="{{ square_table.changesetArray[0]?.square }}"
      filterBy="[]"
      isMultiplayerEdited={false}
      notificationDuration={4.5}
      query={include("../lib/update_square_data.sql", "string")}
      resourceDisplayName="Supabase - Demo"
      resourceName="b4731250-4b92-46f4-a6f7-45cca5606d79"
      resourceTypeOverride=""
      runWhenModelUpdates={false}
      showSuccessToaster={false}
      showUpdateSetValueDynamicallyToggle={false}
      tableName="square_data"
      updateSetValueDynamically={true}
      warningCodes={[]}
    >
      <Event
        id="1de1eb2e"
        event="success"
        method="trigger"
        params={{}}
        pluginId="getSquareData"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        id="4533cb34"
        event="success"
        method="refresh"
        params={{}}
        pluginId="square_table"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
    </SqlQueryUnified>
    <SqlQueryUnified
      id="getSquareData"
      query={include("../lib/getSquareData.sql", "string")}
      resourceDisplayName="Supabase - Demo"
      resourceName="b4731250-4b92-46f4-a6f7-45cca5606d79"
      resourceTypeOverride=""
      warningCodes={[]}
    >
      <Event
        id="16d48761"
        event="success"
        method="setValue"
        params={{ map: { value: "{{ _.map(self.data.square, _.toNumber) }}" } }}
        pluginId="squareValues"
        type="state"
        waitMs="0"
        waitType="debounce"
      />
    </SqlQueryUnified>
    <SqlQueryUnified
      id="update_square_notes_data"
      isMultiplayerEdited={false}
      query={include("../lib/update_square_notes_data.sql", "string")}
      resourceDisplayName="Supabase - Demo"
      resourceName="b4731250-4b92-46f4-a6f7-45cca5606d79"
      resourceTypeOverride=""
      runWhenModelUpdates={false}
      showSuccessToaster={false}
      warningCodes={[]}
    >
      <Event
        id="8474f9e6"
        event="success"
        method="trigger"
        params={{}}
        pluginId="getSquareNotes"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        id="44ff5e33"
        event="success"
        method="refresh"
        params={{}}
        pluginId="square_table"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
    </SqlQueryUnified>
    <SqlQueryUnified
      id="getSquareNotes"
      query={include("../lib/getSquareNotes.sql", "string")}
      resourceDisplayName="Supabase - Demo"
      resourceName="b4731250-4b92-46f4-a6f7-45cca5606d79"
      resourceTypeOverride=""
      warningCodes={[]}
    >
      <Event
        id="bc009c73"
        event="success"
        method="setValue"
        params={{ map: { value: "{{ self.data.notes }}" } }}
        pluginId="squareNotes"
        type="state"
        waitMs="0"
        waitType="debounce"
      />
    </SqlQueryUnified>
    <SqlQueryUnified
      id="deleteSquareNote"
      isMultiplayerEdited={false}
      query={include("../lib/deleteSquareNote.sql", "string")}
      resourceDisplayName="Supabase - Demo"
      resourceName="b4731250-4b92-46f4-a6f7-45cca5606d79"
      resourceTypeOverride=""
      runWhenModelUpdates={false}
      showSuccessToaster={false}
      warningCodes={[]}
    >
      <Event
        id="d0a8e901"
        event="success"
        method="trigger"
        params={{}}
        pluginId="getSquareNotes"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        id="77446ec6"
        event="success"
        method="refresh"
        params={{}}
        pluginId="square_table"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
    </SqlQueryUnified>
    <SqlQueryUnified
      id="deleteSquareValue"
      isMultiplayerEdited={false}
      query={include("../lib/deleteSquareValue.sql", "string")}
      resourceDisplayName="Supabase - Demo"
      resourceName="b4731250-4b92-46f4-a6f7-45cca5606d79"
      resourceTypeOverride=""
      runWhenModelUpdates={false}
      showSuccessToaster={false}
      warningCodes={[]}
    >
      <Event
        id="d0a8e901"
        event="success"
        method="trigger"
        params={{}}
        pluginId="getSquareData"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        id="77446ec6"
        event="success"
        method="refresh"
        params={{}}
        pluginId="square_table"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
    </SqlQueryUnified>
    <SqlQueryUnified
      id="update_tips_comms_table"
      query={include("../lib/update_tips_comms_table.sql", "string")}
      resourceDisplayName="Supabase - Demo"
      resourceName="b4731250-4b92-46f4-a6f7-45cca5606d79"
      resourceTypeOverride=""
      runWhenModelUpdates={false}
      warningCodes={[]}
    >
      <Event
        id="afa8418b"
        event="success"
        method="trigger"
        params={{}}
        pluginId="getTipsCommsData"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        id="6196f9cc"
        event="success"
        method="refresh"
        params={{}}
        pluginId="tips_commissions_table"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
    </SqlQueryUnified>
  </Folder>
  <Function
    id="missingSquareDates"
    funcBody={include("../lib/missingSquareDates.js", "string")}
  />
  <SqlQueryUnified
    id="getSquareDataMaxDate"
    notificationDuration={4.5}
    query={include("../lib/getSquareDataMaxDate.sql", "string")}
    resourceDisplayName="Supabase - Demo"
    resourceName="b4731250-4b92-46f4-a6f7-45cca5606d79"
    resourceTypeOverride=""
    showSuccessToaster={false}
    warningCodes={[]}
  />
  <SqlQueryUnified
    id="insertMissingSquareDates"
    notificationDuration={4.5}
    query={include("../lib/insertMissingSquareDates.sql", "string")}
    resourceDisplayName="Supabase - Demo"
    resourceName="b4731250-4b92-46f4-a6f7-45cca5606d79"
    resourceTypeOverride=""
    runWhenModelUpdates={false}
    showSuccessToaster={false}
    warningCodes={[]}
  />
  <SqlQueryUnified
    id="getSquareDataDates"
    notificationDuration={4.5}
    query={include("../lib/getSquareDataDates.sql", "string")}
    resourceDisplayName="Supabase - Demo"
    resourceName="b4731250-4b92-46f4-a6f7-45cca5606d79"
    resourceTypeOverride=""
    showSuccessToaster={false}
    warningCodes={[]}
  />
  <State id="squareDatesSyncInProgress" value="false" />
  <RESTQuery
    id="fetchConnecteamUsers"
    isMultiplayerEdited={false}
    notificationDuration={4.5}
    query="get-connecteam-users"
    queryDisabled="{{ true }}"
    resourceDisplayName="connecteam_fetch"
    resourceName="574b2811-483f-4dbf-8038-1d27f6f24a72"
    showSuccessToaster={false}
  />
  <RESTQuery
    id="get_tips_from_square"
    body={
      '[{"key":"name","value":"Functions"},{"key":"start","value":"{{ tips_date_start.value }}"},{"key":"end","value":"{{ tips_date_end.value }}"}]'
    }
    bodyType="json"
    cookies="[]"
    headers={'[{"key":"Content-Type","value":"application/json"}]'}
    isMultiplayerEdited={false}
    notificationDuration={4.5}
    query="get-square-tips"
    queryDisabled="{{ true }}"
    resourceDisplayName="connecteam_fetch"
    resourceName="574b2811-483f-4dbf-8038-1d27f6f24a72"
    resourceTypeOverride=""
    runWhenModelUpdates={false}
    runWhenPageLoadsDelay="1000"
    showSuccessToaster={false}
    type="POST"
  />
  <Frame
    id="$main3"
    enableFullBleed={false}
    isHiddenOnDesktop={false}
    isHiddenOnMobile={false}
    padding="8px 12px"
    sticky={null}
    type="main"
  >
    <Navigation
      id="navigation2"
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
    <Divider id="divider3" />
    <Select
      id="tips_select_pay_period"
      data="{{ calculate_pay_periods.data }}"
      emptyMessage="No options"
      label="Select Pay Period"
      labelPosition="top"
      labels=""
      overlayMaxHeight={375}
      placeholder="Select an option"
      showSelectionIndicator={true}
      values="{{ item }}"
    >
      <Event
        id="edf7c1ef"
        event="change"
        method="trigger"
        params={{}}
        pluginId="set_tips_last_selected_pay_period"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        id="fd98dc89"
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
        pluginId="tips_commissions_table"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        id="fd98dc89"
        event="change"
        method="setFilterStack"
        params={{
          map: {
            filterStack: {
              filters:
                '[\n  {\n    "columnId": "date",\n    "operator": ">=",\n    "value": {{ moment.utc(self.value.split("-")[0], "M/D/YYYY").startOf(\'day\').format("YYYY-MM-DD") }}\n  },\n  {\n    "columnId": "date",\n    "operator": "<=",\n    "value": {{ moment.utc(self.value.split("-")[1], "M/D/YYYY").add(1, \'day\').format("YYYY-MM-DD") }}\n  }\n]',
              operator: "and",
            },
          },
        }}
        pluginId="square_table"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        id="fd98dc89"
        event="change"
        method="trigger"
        params={{
          map: {
            options: {
              object: {
                onSuccess: null,
                onFailure: null,
                additionalScope: null,
              },
            },
          },
        }}
        pluginId="getSquareData"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        id="7d278656"
        event="focus"
        method="run"
        params={{
          map: {
            src: "// Sync missing square_data dates for the currently selected pay period.\n// This is guarded to prevent re-entrant loops.\n\nif (squareDatesSyncInProgress.value) return;\n\nsquareDatesSyncInProgress.setValue(true);\ntry {\n  // Load current DB state used by missingSquareDates\n  await getSquareDataDates.trigger();\n  await getSquareDataMaxDate.trigger();\n\n  const missing = missingSquareDates.value?.missing ?? [];\n  const eligible = missingSquareDates.value?.eligible ?? [];\n\n  if (missing.length > 0 && eligible.length === 0) {\n    utils.showNotification({\n      title: 'Square dates not inserted',\n      description: `There are ${missing.length} missing date(s), but none are eligible to insert because it would create a gap after ${missingSquareDates.value?.lastDate ?? '(no existing date)'}.`,\n      notificationType: 'warning',\n    });\n    return;\n  }\n\n  if (eligible.length > 0) {\n    await insertMissingSquareDates.trigger();\n\n    // Refresh downstream data after insert\n    await getSquareDataDates.trigger();\n    await getSquareData.trigger();\n    await getSquareDataMaxDate.trigger();\n  }\n} finally {\n  squareDatesSyncInProgress.setValue(false);\n}",
          },
        }}
        pluginId=""
        type="script"
        waitMs="0"
        waitType="debounce"
      />
    </Select>
    <Form
      id="tips_form"
      footerPadding="4px 12px"
      headerPadding="4px 12px"
      initialData=""
      padding="12px"
      requireValidation={true}
      resetAfterSubmit={true}
      scroll={true}
      showBody={true}
      showFooter={true}
    >
      <Header>
        <Text id="formTitle1" value="#### Form title" verticalAlign="center" />
      </Header>
      <Body>
        <Select
          id="form_name"
          data="{{ getUsers.data }}"
          emptyMessage="No options"
          label="Name"
          labelPosition="top"
          labels="{{ item.full_name }}"
          overlayMaxHeight={375}
          placeholder="Select an option"
          required={true}
          showSelectionIndicator={true}
          values="{{ item.full_name }}"
        />
        <Select
          id="form_date"
          data="{{((s) => { const [a, b] = s.split('-').map(d => moment(d, 'M/D/YYYY')); return _.times(b.diff(a, 'days') + 1, i => a.clone().add(i, 'days').format('MMM D, YYYY')); })(tips_select_pay_period.value) }}"
          emptyMessage="No options"
          label="Date"
          labelPosition="top"
          overlayMaxHeight={375}
          placeholder="Select an option"
          required={true}
          showSelectionIndicator={true}
        />
        <NumberInput
          id="form_tip"
          allowNull={true}
          currency="USD"
          format="currency"
          formDataKey="Tip"
          inputTooltip="`Enter` to save, `Esc` to cancel"
          inputValue={0}
          label="Tip"
          labelPosition="top"
          placeholder="Enter tip"
          showSeparators={true}
          showStepper={true}
          value=""
        />
        <NumberInput
          id="form_commission"
          allowNull={true}
          currency="USD"
          decimalPlaces="2"
          format="currency"
          formDataKey="Commission"
          inputValue={0}
          label="Commission"
          labelPosition="top"
          placeholder="Enter commission"
          showSeparators={true}
          showStepper={true}
          value=""
        />
        <NumberInput
          id="form_deductions"
          allowNull={true}
          currency="USD"
          format="currency"
          formDataKey="Commission"
          inputValue={0}
          label="Deductions"
          labelPosition="top"
          placeholder="Enter deductions"
          showSeparators={true}
          showStepper={true}
          value=""
        />
        <Select
          id="form_deduction_reason"
          data="{{ getDeductionReasons.data }}"
          emptyMessage="No options"
          label="Deduction Reason"
          labelPosition="top"
          overlayMaxHeight={375}
          placeholder="Select an option"
          showSelectionIndicator={true}
          values="{{ item.reason }}"
        />
        <NumberInput
          id="form_out_of_state"
          allowNull={true}
          currency="USD"
          format="currency"
          formDataKey="Out of State Pay"
          inputValue={0}
          label="Out of State Pay"
          labelPosition="top"
          placeholder="Enter out of state pay"
          showSeparators={true}
          showStepper={true}
          value=""
        />
      </Body>
      <Footer>
        <Button
          id="formButton"
          submit={true}
          submitTargetId="tips_form"
          text="Submit"
        />
      </Footer>
      <Event
        id="b07d9b51"
        event="submit"
        method="trigger"
        params={{}}
        pluginId="tips_formSubmitHandler"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </Form>
    <Statistic
      id="tips_total_stat"
      currency="USD"
      formattingStyle="currency"
      label="Pay Period Tip Total"
      positiveTrend="{{ self.value >= 0 }}"
      secondaryCurrency="USD"
      secondaryEnableTrend={true}
      secondaryFormattingStyle="percent"
      secondaryPositiveTrend="{{ self.secondaryValue >= 0 }}"
      secondaryShowSeparators={true}
      secondarySignDisplay="trendArrows"
      secondaryValue=""
      showSeparators={true}
      value="{{ _.sumBy(tips_commissions_table.data.filter(d => moment.utc(d.date) >= tips_date_start.value && moment.utc(d.date) <= tips_date_end.value), r => _.toNumber(r.tip)) }}"
    />
    <LinkList
      id="linkList1"
      itemMode="static"
      label=""
      labelPosition="top"
      showUnderline="never"
      style={{
        fontSize: "h6Font",
        fontWeight: "h6Font",
        fontFamily: "h6Font",
        label: "primary",
      }}
    >
      <Option
        id="00030"
        icon="bold/interface-arrows-bend-down-right-2-alternate"
        label="Go to Square Table"
      >
        <Event
          id="a232ba67"
          event="click"
          method="scrollIntoView"
          params={{
            map: {
              options: { object: { block: "nearest", behavior: "auto" } },
            },
          }}
          pluginId="square_table"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </Option>
    </LinkList>
    <Statistic
      id="commissions_total_stat"
      currency="USD"
      formattingStyle="currency"
      label="Pay Period Move Commission Total"
      positiveTrend="{{ self.value >= 0 }}"
      secondaryCurrency="USD"
      secondaryEnableTrend={true}
      secondaryFormattingStyle="percent"
      secondaryPositiveTrend="{{ self.secondaryValue >= 0 }}"
      secondaryShowSeparators={true}
      secondarySignDisplay="trendArrows"
      secondaryValue=""
      showSeparators={true}
      value="{{ _.sumBy(tips_commissions_table.data.filter(d => moment.utc(d.date) >= tips_date_start.value && moment.utc(d.date) <= tips_date_end.value), r => _.toNumber(r.commission)) }}"
    />
    <Statistic
      id="junk_commissions_total_stat"
      currency="USD"
      formattingStyle="currency"
      label="Pay Period Junk Commission Total"
      positiveTrend="{{ self.value >= 0 }}"
      secondaryCurrency="USD"
      secondaryEnableTrend={true}
      secondaryFormattingStyle="percent"
      secondaryPositiveTrend="{{ self.secondaryValue >= 0 }}"
      secondaryShowSeparators={true}
      secondarySignDisplay="trendArrows"
      secondaryValue=""
      showSeparators={true}
      value="{{ (() => {
  const total = _.sum(tips_bonus_transformer.value);
  return (total >= tips_adj_bonus_threshold.value && tips_adj_bonus_threshold.value > 0) ? tips_adj_bonus_threshold.value : total;
})() }}"
    />
    <Statistic
      id="overall_commissions_total_stat"
      currency="USD"
      formattingStyle="currency"
      label="Pay Period Overall Commission Total"
      positiveTrend="{{ self.value >= 0 }}"
      secondaryCurrency="USD"
      secondaryEnableTrend={true}
      secondaryFormattingStyle="percent"
      secondaryPositiveTrend="{{ self.secondaryValue >= 0 }}"
      secondaryShowSeparators={true}
      secondarySignDisplay="trendArrows"
      secondaryValue=""
      showSeparators={true}
      value="{{ commissions_total_stat.value + junk_commissions_total_stat.value }}"
    />
    <Text id="text5" value="#### Top 5 Commissions" verticalAlign="center" />
    <Text id="text4" value="#### Top 5 Tips" verticalAlign="center" />
    <Table
      id="top_commissions"
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ _(tips_commissions_table.data.filter(r => moment(r.date) >= moment(tips_date_start.value) && moment(r.date) <= moment(tips_date_end.value))).groupBy('name').map((entries, name) => ({ name, commissions: _.sumBy(entries, e => parseFloat(e.commission) || 0) })).orderBy('commissions', 'desc').take(5).value() }}
"
      defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
      defaultSort={[{ object: { columnId: "62184", direction: "desc" } }]}
      emptyMessage="No rows found"
      enableSaveActions={true}
      heightType="auto"
      primaryKeyColumnId="55ef5"
      rowHeight="medium"
      showBorder={true}
      toolbarPosition="bottom"
    >
      <Column
        id="55ef5"
        alignment="left"
        editable={false}
        editableOptions={{ spellCheck: false }}
        format="string"
        groupAggregationMode="none"
        key="name"
        label="Name"
        placeholder="Enter value"
        position="center"
        size={103.58332824707031}
        summaryAggregationMode="none"
      />
      <Column
        id="6a71d"
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
        key="commissions"
        label="Commissions"
        placeholder="Enter value"
        position="center"
        size={30}
        summaryAggregationMode="none"
      />
    </Table>
    <Table
      id="top_tips"
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ _(tips_commissions_table.data.filter(r => moment(r.date) >= moment(tips_date_start.value) && moment(r.date) <= moment(tips_date_end.value))).groupBy('name').map((entries, name) => ({ name, tips: _.sumBy(entries, e => parseFloat(e.tip) || 0) })).orderBy('tips', 'desc').take(5).value() }}
"
      defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
      defaultSort={[{ object: { columnId: "62184", direction: "desc" } }]}
      emptyMessage="No rows found"
      enableSaveActions={true}
      heightType="auto"
      primaryKeyColumnId="55ef5"
      rowHeight="medium"
      showBorder={true}
      toolbarPosition="bottom"
    >
      <Column
        id="55ef5"
        alignment="left"
        editable={false}
        editableOptions={{ spellCheck: false }}
        format="string"
        groupAggregationMode="none"
        key="name"
        label="Name"
        placeholder="Enter value"
        position="center"
        size={113.58332824707031}
        summaryAggregationMode="none"
      />
      <Column
        id="4b0da"
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
        key="tips"
        label="Tips"
        placeholder="Enter value"
        position="center"
        size={30}
        summaryAggregationMode="none"
      />
    </Table>
    <Text id="text7" value="### Tips and Commissions" verticalAlign="center" />
    <Button
      id="button1"
      style={{
        map: {
          background: '{{ tips_sort_by_date.value ? "#1E4392" : "#3170F9" }}',
        },
      }}
      text="Sort by Date"
    >
      <Event
        id="f94872f5"
        enabled=""
        event="click"
        method="setValue"
        params={{ map: { value: "{{ !tips_sort_by_date.value }}" } }}
        pluginId="tips_sort_by_date"
        type="state"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        id="dcdd081a"
        event="click"
        method="run"
        params={{
          map: {
            src: 'if (tips_sort_by_date.value == true) {\n  tips_commissions_table.setGrouping();\n} else {\n  tips_commissions_table.setGrouping({columnId: "name", sortDirection: "asc"})\n}',
          },
        }}
        pluginId=""
        type="script"
        waitMs="0"
        waitType="debounce"
      />
    </Button>
    <Alert2
      id="alert4"
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
    <Table
      id="tips_commissions_table"
      autoColumnWidth={true}
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ getTipsCommsData.data }}"
      defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
      defaultSort={[{ object: { columnId: "d996e", direction: "asc" } }]}
      dynamicColumnProperties={{ formatByIndex: "auto" }}
      emptyMessage="No rows found"
      enableSaveActions={true}
      groupByColumns={[{ map: { columnId: "bd649" } }]}
      groupedColumnConfig={{ expandByDefault: false, size: 158 }}
      heightType="auto"
      primaryKeyColumnId="809c6"
      showBorder={true}
      showFooter={true}
      showHeader={true}
      showSummaryRow={true}
      toolbarPosition="bottom"
    >
      <Column
        id="809c6"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="true"
        key="id"
        label="ID"
        placeholder="Enter value"
        position="center"
        size={0}
        summaryAggregationMode="sum"
      />
      <Column
        id="bd649"
        alignment="left"
        editable={false}
        editableOptions={{ spellCheck: false }}
        format="string"
        groupAggregationMode="none"
        hidden="{{ tips_sort_by_date.value == false }}"
        key="name"
        label="Name"
        placeholder="Enter value"
        position="center"
        size={0}
        summaryAggregationMode="none"
      />
      <Column
        id="d996e"
        alignment="left"
        editable="false"
        format="date"
        groupAggregationMode="none"
        key="date"
        label="Date"
        placeholder="Enter value"
        position="center"
        size={0}
        summaryAggregationMode="none"
      />
      <Column
        id="ee09f"
        alignment="right"
        editable="true"
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
        key="tip"
        label="Tip"
        placeholder="Enter value"
        position="center"
        size={0}
        summaryAggregationMode="sum"
      />
      <Column
        id="9d9cd"
        alignment="right"
        cellTooltip="{{ item }}"
        cellTooltipMode="custom"
        editable="true"
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
        key="commission"
        label="Commission"
        placeholder="Enter value"
        position="center"
        size={0}
        summaryAggregationMode="sum"
      />
      <Column
        id="944fc"
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
        groupAggregationMode="none"
        hidden="true"
        label="Daily Tip Total"
        placeholder="Enter value"
        position="center"
        referenceId="dailyTipTotal"
        size={0}
        summaryAggregationMode="sum"
        valueOverride="{{ _.sumBy(self.data.filter(d => d.date === currentSourceRow.date), r => _.toNumber(r.tip)) }}"
      />
      <Column
        id="fcd32"
        alignment="right"
        editable="true"
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
        key="deductions"
        label="Deductions"
        placeholder="Enter value"
        position="center"
        size={0}
        summaryAggregationMode="sum"
      />
      <Column
        id="d9af9"
        alignment="left"
        editable="true"
        editableOptions={{ spellCheck: false }}
        format="string"
        groupAggregationMode="none"
        key="deduction_reason"
        label="Deduction reason"
        placeholder="Enter value"
        position="center"
        size={0}
        summaryAggregationMode="none"
      />
      <Column
        id="ad5b6"
        alignment="right"
        cellTooltip="{{ item }}"
        cellTooltipMode="custom"
        editable="true"
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
        key="out_of_state_pay"
        label="Out of state pay"
        placeholder="Enter value"
        position="center"
        size={0}
        summaryAggregationMode="sum"
      />
      <Column
        id="7ca8d"
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
        groupAggregationMode="max"
        label="Adj Bonus"
        placeholder="Enter value"
        position="center"
        referenceId="adjBonus"
        size={0}
        summaryAggregationMode="sum"
        valueOverride="{{ map_bonuses_to_captains.value[currentSourceRow.name]?.adj_bonus }}"
      />
      <Column
        id="54dc2"
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
        groupAggregationMode="max"
        hidden="true"
        label="Bonus"
        placeholder="Enter value"
        position="center"
        referenceId="bonus"
        size={0}
        summaryAggregationMode="sum"
        valueOverride="{{ map_bonuses_to_captains.value[currentSourceRow.name]?.bonus }}"
      />
      <Column
        id="42d90"
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
          id="f2de64b7"
          event="clickToolbar"
          method="exportData"
          params={{ map: { options: { map: { fileType: "csv" } } } }}
          pluginId="tips_commissions_table"
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
          id="e5e7fd5e"
          event="clickToolbar"
          method="refresh"
          pluginId="tips_commissions_table"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
      <Event
        id="734493dd"
        event="save"
        method="trigger"
        params={{}}
        pluginId="update_tips_comms_table"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </Table>
    <Text id="text6" value="### Square" verticalAlign="center" />
    <Table
      id="square_table"
      actionsOverflowPosition={2}
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ square_dates.value }}"
      defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
      dynamicColumnProperties={{ formatByIndex: "auto" }}
      emptyMessage="No rows found"
      enableSaveActions={true}
      heightType="auto"
      rowHeight="small"
      showBorder={true}
      showFooter={true}
      showHeader={true}
      showSummaryRow={true}
      toolbarPosition="bottom"
    >
      <Column
        id="c9800"
        alignment="left"
        editable={false}
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
        id="8a4d7"
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
        label="Daily Tip Total"
        placeholder="Enter value"
        position="center"
        referenceId="dailyTipTotal"
        size={111}
        summaryAggregationMode="sum"
        valueOverride="{{ daily_tip_total.value[i] }}"
      />
      <Column
        id="11eee"
        alignment="right"
        editable="true"
        editableOptions={{ showStepper: false, min: "" }}
        format="currency"
        formatOptions={{
          currency: "USD",
          currencySign: "standard",
          notation: "standard",
          showSeparators: true,
          currencyDisplay: "symbol",
        }}
        groupAggregationMode="sum"
        label="Square"
        placeholder="Enter value"
        position="center"
        referenceId="square"
        size={115}
        summaryAggregationMode="sum"
        valueOverride="{{ square_transformer.value[i] }}"
      />
      <Column
        id="85345"
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
        label="Delta"
        placeholder="Enter value"
        position="center"
        referenceId="delta"
        size={111}
        summaryAggregationMode="sum"
        valueOverride="{{ daily_tip_total.value[i] - square_transformer.value[i] }}"
      />
      <Column
        id="4c68d"
        alignment="left"
        editable="true"
        editableOptions={{ spellCheck: false }}
        format="string"
        groupAggregationMode="none"
        label="Notes"
        placeholder="Enter value"
        position="center"
        referenceId="notes"
        size={100}
        summaryAggregationMode="none"
        valueOverride="{{ square_notes_transformer.value[i] }}"
      />
      <Action
        id="c4162"
        icon="bold/interface-delete-3"
        label="Delete Square Value"
      >
        <Event
          id="10c5e69b"
          event="clickAction"
          method="trigger"
          params={{}}
          pluginId="deleteSquareValue"
          type="datasource"
          waitMs="0"
          waitType="debounce"
        />
      </Action>
      <Action id="b3f61" icon="bold/interface-delete-1" label="Delete Note">
        <Event
          id="087facba"
          event="clickAction"
          method="trigger"
          params={{}}
          pluginId="deleteSquareNote"
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
          id="4a9110d2"
          event="clickToolbar"
          method="exportData"
          pluginId="square_table"
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
          id="cf4dc256"
          event="clickToolbar"
          method="refresh"
          pluginId="square_table"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
      <Event
        id="c961c107"
        event="save"
        method="trigger"
        params={{}}
        pluginId="update_square_notes_data"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        id="b70a89eb"
        event="save"
        method="trigger"
        params={{}}
        pluginId="update_square_data"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </Table>
    <Table
      id="tips_junk_commissions"
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ tips_getJunkCommissions.data }}"
      defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
      emptyMessage="No rows found"
      enableSaveActions={true}
      hidden="true"
      primaryKeyColumnId="1cf43"
      showBorder={true}
      showFooter={true}
      showHeader={true}
      toolbarPosition="bottom"
    >
      <Column
        id="1cf43"
        alignment="left"
        editable={false}
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
        id="647a6"
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
        label="Bonus"
        placeholder="Enter value"
        position="center"
        referenceId="bonus"
        size={100}
        summaryAggregationMode="none"
        valueOverride="{{ tips_bonus_transformer.value[i] }}"
      />
      <Column
        id="9e6ff"
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
        label="Adj Bonus"
        placeholder="Enter value"
        position="center"
        referenceId="adjBonus"
        size={100}
        summaryAggregationMode="none"
        valueOverride="{{ _.sum(tips_bonus_transformer.value) >= tips_adj_bonus_threshold.value ? (tips_adj_bonus_threshold.value / _.sum(tips_bonus_transformer.value)) * tips_bonus_transformer.value[i] : null }}"
      />
      <Column
        id="875dd"
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
        id="89dec"
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
        id="2c7f6"
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
        id="5fa6a"
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
        id="0b3dd"
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
        label="Junk ajs"
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
          id="92b51c01"
          event="clickToolbar"
          method="exportData"
          pluginId="tips_junk_commissions"
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
          id="195e3f87"
          event="clickToolbar"
          method="refresh"
          pluginId="tips_junk_commissions"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
    </Table>
  </Frame>
</Screen>
