<ModalFrame
  id="captain_graph_modal"
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
      id="captain_modal_title"
      value="### {{ totals_by_captain.selectedRow.captain }}"
      verticalAlign="center"
    />
    <Button
      id="modalCloseButton1"
      ariaLabel="Close"
      horizontalAlign="right"
      iconBefore="bold/interface-delete-1"
      style={{ map: { border: "transparent" } }}
      styleVariant="outline"
    >
      <Event
        id="a88f7bcc"
        event="click"
        method="hide"
        params={{}}
        pluginId="captain_graph_modal"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
    </Button>
  </Header>
  <Body>
    <Container
      id="captain_graph_options_container"
      footerPadding="4px 12px"
      headerPadding="4px 12px"
      padding="12px"
      showBody={true}
      showHeader="false"
    >
      <Header>
        <Text
          id="containerTitle3"
          value="#### Options"
          verticalAlign="center"
        />
      </Header>
      <View id="00030" viewKey="View 1">
        <Switch
          id="captain_graph_include_out_of_state"
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
          id="captain_graph_include_utility"
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
          id="captain_graph_include_commissions"
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
      id="captain_graph_date_range"
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
      id="captain_modal_chart"
      barGap={0.4}
      barMode="group"
      hidden="{{ captain_modal_chart.series[0].yData.every(v => v === null) && captain_modal_chart.series[1].yData.every(v => v === null) }}"
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
        datasource="{{ getCaptainGraph.data }}"
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
        xData="{{ getCaptainGraph.data.pay_period }}"
        xDataMode="source"
        yAxis="y"
        yData="{{ getCaptainGraph.data.move_labor_pct }}"
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
        datasource="{{ getCaptainGraph.data }}"
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
        xData="{{ getCaptainGraph.data.pay_period }}"
        xDataMode="source"
        yAxis="y"
        yData="{{ getCaptainGraph.data.junk_labor_pct }}"
        yDataMode="source"
        zData={null}
        zDataMode="manual"
      />
    </Chart>
    <Text
      id="no_graph_data_text"
      hidden="{{ !(captain_modal_chart.series[0].yData.every(v => v === null) && captain_modal_chart.series[1].yData.every(v => v === null)) }}"
      horizontalAlign="center"
      value="## No Data Available"
      verticalAlign="center"
    />
  </Body>
</ModalFrame>
