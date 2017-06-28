ChartPie = require("react-chartjs").Pie

PieChart = React.createClass
	displayName: "PieChart"

	render: ->
		<ChartPie data={@props.data} options={@props.options} width="200" height="200" />

module.exports = PieChart