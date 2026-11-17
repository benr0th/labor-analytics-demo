<ModalFrame
  id="captain_total_labor_graph_modal"
  footerPadding="8px 12px"
  headerPadding="8px 12px"
  hidden={true}
  hideOnEscape={true}
  isHiddenOnMobile={true}
  overlayInteraction={true}
  padding="8px 12px"
  showHeader={true}
  showOverlay={true}
  size="large"
>
  <Header>
    <Text
      id="modalTitle1"
      value="### Captain All-Time Labor %"
      verticalAlign="center"
    />
    <Button
      id="modalCloseButton4"
      ariaLabel="Close"
      horizontalAlign="right"
      iconBefore="bold/interface-delete-1"
      style={{ map: { border: "transparent" } }}
      styleVariant="outline"
    >
      <Event
        id="4735c173"
        event="click"
        method="setHidden"
        params={{ map: { hidden: true } }}
        pluginId="captain_total_labor_graph_modal"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
    </Button>
  </Header>
  <Body>
    <Container
      id="captain_graph_options_container2"
      footerPadding="4px 12px"
      headerPadding="4px 12px"
      padding="12px"
      showBody={true}
      showHeader="false"
    >
      <Header>
        <Text
          id="containerTitle4"
          value="#### Options"
          verticalAlign="center"
        />
      </Header>
      <View id="00030" viewKey="View 1">
        <Switch
          id="captain_graph_include_out_of_state2"
          label="Include Out of State"
          value="{{ include_out_of_state.value }}"
        >
          <Event
            id="d2da7d3f"
            event="change"
            method="setValue"
            params={{ map: { value: "{{ self.value }}" } }}
            pluginId="include_out_of_state"
            type="widget"
            waitMs="0"
            waitType="debounce"
          />
        </Switch>
        <Switch
          id="captain_graph_include_utility2"
          label="Include Utility"
          value="{{ include_utility.value }}"
        >
          <Event
            id="d2da7d3f"
            event="change"
            method="setValue"
            params={{ map: { value: "{{ self.value }}" } }}
            pluginId="include_utility"
            type="widget"
            waitMs="0"
            waitType="debounce"
          />
        </Switch>
        <Switch
          id="captain_graph_include_commissions2"
          label="Include Commissions"
          value="{{ include_commissions.value }}"
        >
          <Event
            id="d2da7d3f"
            event="change"
            method="setValue"
            params={{ map: { value: "{{ self.value }}" } }}
            pluginId="include_commissions"
            type="widget"
            waitMs="0"
            waitType="debounce"
          />
        </Switch>
      </View>
    </Container>
    <Container
      id="container1"
      footerPadding="4px 12px"
      headerPadding="4px 12px"
      padding="12px"
      showBody={true}
    >
      <Header>
        <Text
          id="containerTitle5"
          value="#### Container title"
          verticalAlign="center"
        />
      </Header>
      <View id="00030" viewKey="View 1">
        <Switch
          id="all_time_labor_show_move"
          disabled="{{ all_time_labor_show_junk.value == false }}"
          label="Show Move"
          value="true"
        >
          <Event
            id="314c7cb2"
            event="change"
            method="trigger"
            params={{
              map: {
                options: {
                  map: {
                    additionalScope: {
                      map: { toggle_state: "{{ self.value }}" },
                    },
                  },
                },
              },
            }}
            pluginId="toggle_all_time_labor_show_move"
            type="datasource"
            waitMs="0"
            waitType="debounce"
          />
        </Switch>
        <Switch
          id="all_time_labor_show_junk"
          disabled="{{ all_time_labor_show_move.value == false }}"
          label="Show Junk"
        >
          <Event
            id="6ba079de"
            event="change"
            method="trigger"
            params={{
              map: {
                options: {
                  map: {
                    additionalScope: {
                      map: { toggle_state: "{{ self.value }}" },
                    },
                  },
                },
              },
            }}
            pluginId="toggle_all_time_labor_show_junk"
            type="datasource"
            waitMs="0"
            waitType="debounce"
          />
        </Switch>
      </View>
    </Container>
    <Text
      id="text13"
      style={{ fontSize: "h6Font", fontWeight: "h6Font", fontFamily: "h6Font" }}
      value="Shows Captains with 5 or more jobs."
      verticalAlign="center"
    />
    <Chart
      id="captain_total_labor_modal_chart"
      barGap={0.4}
      barMode="group"
      hidden="{{ captain_total_labor_modal_chart.series[0].yData.every(v => v === null) && captain_total_labor_modal_chart.series[1].yData.every(v => v === null) }}"
      legendPosition="bottom"
      selectedPoints="[]"
      stackedBarTotalsDataLabelPosition="none"
      title={null}
      xAxisRangeMax=""
      xAxisRangeMin=""
      xAxisShowTickLabels={true}
      xAxisTickFormatMode="gui"
      xAxisTitle="Captain"
      xAxisTitleStandoff="20"
      yAxis2LineWidth={1}
      yAxis2RangeMax=""
      yAxis2RangeMin=""
      yAxis2ShowTickLabels={true}
      yAxis2TickFormatMode="gui"
      yAxis2TitleStandoff={20}
      yAxisGrid={true}
      yAxisRangeMax=""
      yAxisRangeMin=""
      yAxisShowLine={true}
      yAxisShowTickLabels={true}
      yAxisSort="ascending"
      yAxisTickFormat=".0%"
      yAxisTickFormatMode="gui"
      yAxisTitle="Labor %"
      yAxisTitleStandoff={20}
    >
      <Series
        id="0"
        aggregationType="none"
        colorArray={{ array: ["{{ theme.primary }}"] }}
        colorArrayDropDown={{ array: ["{{ theme.primary }}"] }}
        colorInputMode="colorArrayDropDown"
        connectorLineColor="#000000"
        dataLabelPosition="none"
        datasource="{{ getAllCaptainsTotalLaborPercentGraph.data }}"
        datasourceMode="source"
        decreasingBorderColor="{{ theme.danger }}"
        decreasingColor="{{ theme.danger }}"
        filteredGroups={null}
        filteredGroupsMode="source"
        gradientColorArray={{
          array: [
            { array: ["0.0", "{{ theme.success }}"] },
            { array: ["1.0", "{{ theme.primary }}"] },
          ],
        }}
        groupBy={{ array: [] }}
        groupByDropdownType="source"
        groupByStyles={{}}
        hoverTemplate="<b>%{x}</b><br>%{fullData.name}: %{y:.2%}<extra></extra>"
        hoverTemplateArray="<b>%{x}</b><br>%{fullData.name}: %{y:.2%}<extra></extra>"
        hoverTemplateMode="source"
        increasingBorderColor="{{ theme.success }}"
        increasingColor="{{ theme.success }}"
        lineColor="rgba(255, 162, 0, 1)"
        lineDash="solid"
        lineShape="linear"
        lineUnderFillMode="none"
        lineWidth={2}
        markerBorderColor={null}
        markerBorderWidth={0}
        markerColor="#ffa200"
        markerSize={6}
        markerSymbol="circle"
        name="Move Labor %"
        showMarkers={true}
        textTemplate={null}
        textTemplateMode="manual"
        type="bar"
        waterfallBase={0}
        waterfallMeasures={null}
        waterfallMeasuresMode="source"
        xData="{{ getAllCaptainsTotalLaborPercentGraph.data.captain }}"
        xDataMode="source"
        yAxis="y"
        yData="{{ getAllCaptainsTotalLaborPercentGraph.data.move_labor_pct }}"
        yDataMode="source"
        zData={null}
        zDataMode="manual"
      />
      <Series
        id="1"
        aggregationType="none"
        colorArray={{ array: ["{{ theme.primary }}"] }}
        colorArrayDropDown={{ array: ["{{ theme.primary }}"] }}
        colorInputMode="colorArrayDropDown"
        connectorLineColor="#000000"
        dataLabelPosition="none"
        datasource="{{ getAllCaptainsTotalLaborPercentGraph.data }}"
        datasourceMode="source"
        decreasingBorderColor="{{ theme.danger }}"
        decreasingColor="{{ theme.danger }}"
        filteredGroups={null}
        filteredGroupsMode="source"
        gradientColorArray={{
          array: [
            { array: ["0.0", "{{ theme.success }}"] },
            { array: ["1.0", "{{ theme.primary }}"] },
          ],
        }}
        groupBy={{ array: [] }}
        groupByDropdownType="source"
        groupByStyles={{}}
        hidden={false}
        hiddenMode="manual"
        hoverTemplate="<b>%{x}</b><br>%{fullData.name}: %{y:.2%}<extra></extra>"
        hoverTemplateArray="<b>%{x}</b><br>%{fullData.name}: %{y:.2%}<extra></extra>"
        hoverTemplateMode="source"
        increasingBorderColor="{{ theme.success }}"
        increasingColor="{{ theme.success }}"
        lineColor="rgba(255, 162, 0, 1)"
        lineDash="solid"
        lineShape="linear"
        lineUnderFillMode="none"
        lineWidth={2}
        markerBorderColor={null}
        markerBorderWidth={0}
        markerColor="{{ theme.primary }}"
        markerSize={6}
        markerSymbol="circle"
        name="Junk Labor %"
        showMarkers={true}
        textTemplateMode="manual"
        type="bar"
        waterfallBase={0}
        waterfallMeasures={null}
        waterfallMeasuresMode="source"
        xData="{{ getAllCaptainsTotalLaborPercentGraph.data.captain }}"
        xDataMode="source"
        yAxis="y"
        yData="{{ getAllCaptainsTotalLaborPercentGraph.data.junk_labor_pct }}"
        yDataMode="source"
        zData={null}
        zDataMode="manual"
      />
      <Series
        id="2"
        aggregationType="none"
        colorArray={{ array: ["{{ theme.primary }}"] }}
        colorArrayDropDown={{ array: ["{{ theme.primary }}"] }}
        colorInputMode="colorArrayDropDown"
        connectorLineColor="#000000"
        dataLabelPosition="none"
        datasourceMode="manual"
        decreasingBorderColor="{{ theme.danger }}"
        decreasingColor="{{ theme.danger }}"
        filteredGroups={null}
        filteredGroupsMode="source"
        gradientColorArray={{
          array: [
            { array: ["0.0", "{{ theme.success }}"] },
            { array: ["1.0", "{{ theme.primary }}"] },
          ],
        }}
        groupBy={{ array: [] }}
        groupByDropdownType="source"
        groupByStyles={{}}
        hidden="{{ all_time_labor_show_move.value == false }}"
        hiddenMode="manual"
        hoverTemplate="<b></b><br>Move Labor Goal: %{y:.0%}<extra></extra>"
        hoverTemplateArray="<b>%{x}</b><br>%{fullData.name}: %{y:.2%}<extra></extra>"
        hoverTemplateMode="source"
        increasingBorderColor="{{ theme.success }}"
        increasingColor="{{ theme.success }}"
        lineColor="rgba(0, 0, 0, 1)"
        lineDash="dot"
        lineShape="linear"
        lineUnderFillMode="none"
        lineWidth={2}
        markerBorderColor={null}
        markerBorderWidth={0}
        markerColor="{{ theme.primary }}"
        markerSize={6}
        markerSymbol="circle"
        name="Move Labor Goal"
        showMarkers={false}
        textTemplateMode="manual"
        type="line"
        waterfallBase={0}
        waterfallMeasures={null}
        waterfallMeasuresMode="source"
        xData="{{ getAllCaptainsTotalLaborPercentGraph.data.captain }}"
        xDataMode="manual"
        yAxis="y"
        yData="{{ _.fill(Array(getAllCaptainsTotalLaborPercentGraph.data.captain.length), move_labor_goal.value) }}"
        yDataMode="manual"
        zData={null}
        zDataMode="manual"
      />
      <Series
        id="3"
        aggregationType="none"
        colorArray={{ array: ["{{ theme.primary }}"] }}
        colorArrayDropDown={{ array: ["{{ theme.primary }}"] }}
        colorInputMode="colorArrayDropDown"
        connectorLineColor="#000000"
        dataLabelPosition="none"
        datasourceMode="manual"
        decreasingBorderColor="{{ theme.danger }}"
        decreasingColor="{{ theme.danger }}"
        filteredGroups={null}
        filteredGroupsMode="source"
        gradientColorArray={{
          array: [
            { array: ["0.0", "{{ theme.success }}"] },
            { array: ["1.0", "{{ theme.primary }}"] },
          ],
        }}
        groupBy={{ array: [] }}
        groupByDropdownType="source"
        groupByStyles={{}}
        hidden="{{ all_time_labor_show_junk.value == false }}"
        hiddenMode="manual"
        hoverTemplate="<b></b><br>Junk Labor Goal: %{y:.0%}<extra></extra>"
        hoverTemplateArray="<b>%{x}</b><br>%{fullData.name}: %{y:.2%}<extra></extra>"
        hoverTemplateMode="source"
        increasingBorderColor="{{ theme.success }}"
        increasingColor="{{ theme.success }}"
        lineColor="{{ theme.danger }}"
        lineDash="dot"
        lineShape="linear"
        lineUnderFillMode="none"
        lineWidth={2}
        markerBorderColor={null}
        markerBorderWidth={0}
        markerColor="{{ theme.primary }}"
        markerSize={6}
        markerSymbol="circle"
        name="Junk Labor Goal"
        showMarkers={false}
        textTemplateMode="manual"
        type="line"
        waterfallBase={0}
        waterfallMeasures={null}
        waterfallMeasuresMode="source"
        xData="{{ getAllCaptainsTotalLaborPercentGraph.data.captain }}"
        xDataMode="manual"
        yAxis="y"
        yData="{{ _.fill(Array(getAllCaptainsTotalLaborPercentGraph.data.captain.length), junk_labor_goal.value) }}"
        yDataMode="manual"
        zData={null}
        zDataMode="manual"
      />
    </Chart>
  </Body>
</ModalFrame>
