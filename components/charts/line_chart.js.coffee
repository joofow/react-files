ChartLine = require("react-chartjs").Line

LineChart = React.createClass
	displayName: "LineChart"

	render: ->
		<ChartLine data={@props.data} options={@props.options} width="350" height="250" />

module.exports = LineChart