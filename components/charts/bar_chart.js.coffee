ChartBar = require("react-chartjs").Bar

BarChart = React.createClass
	displayName: "BarChart"

	render: ->
		<ChartBar data={@props.data} options={@props.options} width="200" height="100" />

module.exports = BarChart