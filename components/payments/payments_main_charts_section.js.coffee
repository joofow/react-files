PaymentsMainChartSection = React.createClass
	displayName: 'PaymentsMainChartSection'

	getInitialState: ->
		final: 600

	render: ->
  example_data = [{ value: 300, color:"#F7464A", highlight: "#FF5A5E", label: "Red" },{ value: 50,color: "#46BFBD", highlight: "#5AD3D1", label: "Green" }, { value: 100,color: "#FDB45C",highlight: "#FFC870",label: "Yellow" }]
  data = {labels: ["January", "February", "March", "April", "May", "June", "July"], datasets: [ {label: "My First dataset",fillColor: "rgba(220,220,220,0.2)",strokeColor: "rgba(220,220,220,1)",pointColor: "rgba(220,220,220,1)",pointStrokeColor: "#fff",pointHighlightFill: "#fff",pointHighlightStroke: "rgba(220,220,220,1)",data: [65, 59, 80, 81, 56, 55, 40]}, {label: "My Second dataset",fillColor: "rgba(151,187,205,0.2)",strokeColor: "rgba(151,187,205,1)",pointColor: "rgba(151,187,205,1)",pointStrokeColor: "#fff",pointHighlightFill: "#fff",pointHighlightStroke: "rgba(151,187,205,1)", data: [28, 48, 40, 19, 86, 27, 90]}]}
  <div className='row charts-section'>
			<div className='medium-6 columns panel'>
				<h2>Payment Breakdown</h2>
			</div>
			<div className='medium-6 columns panel'>
				<h2>Payment Increase</h2>
			</div>
		</div>

module.exports = PaymentsMainChartSection