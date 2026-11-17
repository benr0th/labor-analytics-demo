<ModalFrame
  id="tutorial"
  footerPadding="8px 12px"
  headerPadding="8px 12px"
  hidden={true}
  hideOnEscape={true}
  isHiddenOnMobile={true}
  overlayInteraction={true}
  padding="8px 12px"
  showFooter={true}
  showHeader={true}
  showOverlay={true}
  size="medium"
>
  <Header>
    <Text id="modalTitle2" value="### Welcome!" verticalAlign="center" />
    <Button
      id="modalCloseButton5"
      ariaLabel="Close"
      horizontalAlign="right"
      iconBefore="bold/interface-delete-1"
      style={{ map: { border: "transparent" } }}
      styleVariant="outline"
    >
      <Event
        id="ed6de0c9"
        event="click"
        method="setHidden"
        params={{ map: { hidden: true } }}
        pluginId="tutorial"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
    </Button>
  </Header>
  <Body>
    <Text
      id="text21"
      value="##### Thanks for checking out this demo. 

##### To start, select a pay period in the top left. This will populate all the values and tables."
      verticalAlign="center"
    />
  </Body>
</ModalFrame>
