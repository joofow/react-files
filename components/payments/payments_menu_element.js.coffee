


PaymentsMenuElement = React.createClass
	displayName: "PaymentsMenuElement"
	render:->
		<div className="row panel" >
			<div className="medium-12 columns">
				<h4>{@props.name}</h4>
			</div>
		</div>

module.exports = PaymentsMenuElement