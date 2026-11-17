<GlobalFunctions>
  <Folder id="supabase_queries" />
  <JavascriptQuery
    id="calculate_pay_periods"
    notificationDuration={4.5}
    query={include("./lib/calculate_pay_periods.js", "string")}
    resourceName="JavascriptQuery"
    runWhenPageLoads={true}
    showSuccessToaster={false}
  />
  <SqlQueryUnified
    id="getInitialVersion"
    query={include("./lib/getInitialVersion.sql", "string")}
    resourceDisplayName="Supabase"
    resourceName="7a13180c-5164-4905-9dd2-76ed954900b0"
    warningCodes={[]}
  >
    <Event
      id="6d7def9c"
      event="success"
      method="setValue"
      params={{ map: { value: "{{ self.data.version[0] }}" } }}
      pluginId="initialVersion"
      type="state"
      waitMs="0"
      waitType="debounce"
    />
  </SqlQueryUnified>
  <State id="initialVersion" />
  <SqlQueryUnified
    id="getLatestVersion"
    isMultiplayerEdited={false}
    query={include("./lib/getLatestVersion.sql", "string")}
    queryRefreshTime="60000"
    resourceDisplayName="Supabase"
    resourceName="7a13180c-5164-4905-9dd2-76ed954900b0"
    runWhenModelUpdates={false}
    runWhenPageLoads={true}
    showSuccessToaster={false}
    warningCodes={[]}
  >
    <Event
      id="f6cd0e5e"
      event="success"
      method="setValue"
      params={{ map: { value: "{{ self.data.version[0] }}" } }}
      pluginId="latestVersion"
      type="state"
      waitMs="0"
      waitType="debounce"
    />
  </SqlQueryUnified>
  <State id="latestVersion" />
  <SqlQueryUnified
    id="pushUpdate"
    notificationDuration={4.5}
    query={include("./lib/pushUpdate.sql", "string")}
    resourceDisplayName="Supabase"
    resourceName="7a13180c-5164-4905-9dd2-76ed954900b0"
    runWhenModelUpdates={false}
    showSuccessToaster={false}
    showUpdateSetValueDynamicallyToggle={false}
    updateSetValueDynamically={true}
    warningCodes={[]}
  />
  <State id="showOnlyDiscrepancies" value="false" />
  <State id="compareAgainstCaptain" value="true" />
</GlobalFunctions>
