<ModalFrame
  id="overall_graph_modal"
  footerPadding="8px 12px"
  headerPadding="8px 12px"
  hidden={true}
  hideOnEscape={true}
  isHiddenOnMobile={true}
  overlayInteraction={true}
  padding="8px 12px"
  showFooter="false"
  showHeader={true}
  showOverlay={true}
  size="large"
>
  <Header>
    <Text
      id="overall_graph_modal_title"
      value="### Labor % Over Time"
      verticalAlign="center"
    />
    <Button
      id="modalCloseButton3"
      ariaLabel="Close"
      horizontalAlign="right"
      iconBefore="bold/interface-delete-1"
      style={{ map: { border: "transparent" } }}
      styleVariant="outline"
    >
      <Event
        id="60ef2cce"
        event="click"
        method="setHidden"
        params={{ map: { hidden: true } }}
        pluginId="overall_graph_modal"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
    </Button>
  </Header>
  <Body>
    <Container
      id="overall_graph_options_container"
      footerPadding="4px 12px"
      headerPadding="4px 12px"
      padding="12px"
      showBody={true}
      showHeader="false"
    >
      <Header>
        <Text
          id="containerTitle2"
          value="#### Options"
          verticalAlign="center"
        />
      </Header>
      <View id="00030" viewKey="View 1">
        <Switch
          id="overall_graph_include_out_of_state"
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
          id="overall_graph_include_utility"
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
          id="overall_graph_include_commissions"
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
    <DateRange
      id="overall_graph_date_range"
      dateFormat="MMM d, yyyy"
      endPlaceholder="End date"
      iconBefore="bold/interface-calendar-remove"
      label="Date Range"
      labelPosition="top"
      startPlaceholder="Start date"
      textBetween="-"
      value={{ start: "01/01/2026", end: "{{ new Date() }}" }}
    />
    <Chart
      id="overall_modal_chart"
      barGap={0.4}
      barMode="group"
      hidden="{{ overall_modal_chart.series[0].yData.every(v => v === null) && overall_modal_chart.series[1].yData.every(v => v === null) }}"
      legendPosition="bottom"
      selectedPoints="[]"
      stackedBarTotalsDataLabelPosition="none"
      title={null}
      xAxisRangeMax=""
      xAxisRangeMin=""
      xAxisShowTickLabels={true}
      xAxisTickFormatMode="gui"
      xAxisTitle="Pay Period"
      xAxisTitleStandoff={20}
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
        datasource="{{ getOverallLaborGraph.data }}"
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
        hoverTemplateArray="<b>%{x}</b><br>%{fullData.name}: %{y}<extra></extra>"
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
        type="line"
        waterfallBase={0}
        waterfallMeasures={null}
        waterfallMeasuresMode="source"
        xData="{{ getOverallLaborGraph.data.pay_period }}"
        xDataMode="source"
        yAxis="y"
        yData="{{ getOverallLaborGraph.data.move_labor_pct }}"
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
        datasource="{{ getOverallLaborGraph.data }}"
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
        hoverTemplateArray="<b>%{x}</b><br>%{fullData.name}: %{y}<extra></extra>"
        hoverTemplateMode="source"
        increasingBorderColor="{{ theme.success }}"
        increasingColor="{{ theme.success }}"
        lineColor="{{ theme.primary }}"
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
        type="line"
        waterfallBase={0}
        waterfallMeasures={null}
        waterfallMeasuresMode="source"
        xData="{{ getOverallLaborGraph.data.pay_period }}"
        xDataMode="source"
        yAxis="y"
        yData="{{ getOverallLaborGraph.data.junk_labor_pct }}"
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
        datasource="{{ getOverallLaborGraph.data }}"
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
        hoverTemplateArray="<b>%{x}</b><br>%{fullData.name}: %{y}<extra></extra>"
        hoverTemplateMode="source"
        increasingBorderColor="{{ theme.success }}"
        increasingColor="{{ theme.success }}"
        lineColor="{{ theme.success }}"
        lineDash="solid"
        lineShape="linear"
        lineUnderFillMode="none"
        lineWidth={2}
        markerBorderColor={null}
        markerBorderWidth={0}
        markerColor="{{ theme.success }}"
        markerSize={6}
        markerSymbol="circle"
        name="Overall Labor %"
        showMarkers={true}
        textTemplateMode="manual"
        type="line"
        waterfallBase={0}
        waterfallMeasures={null}
        waterfallMeasuresMode="source"
        xData="{{ getOverallLaborGraph.data.pay_period }}"
        xDataMode="source"
        yAxis="y"
        yData="{{ getOverallLaborGraph.data.overall_labor_pct }}"
        yDataMode="source"
        zData={null}
        zDataMode="manual"
      />
    </Chart>
  </Body>
</ModalFrame>
