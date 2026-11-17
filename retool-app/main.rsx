<App>
  <Include src="./functions.rsx" />
  <Include src="./src/labor_percentage.rsx" />
  <Include src="./src/tips_and_commissions.rsx" />
  <AppStyles id="$appStyles" css={include("./lib/$appStyles.css", "string")} />
</App>
