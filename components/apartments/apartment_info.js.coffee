ApartmentInfo = React.createClass
	displayName: "ApartmentInfo"

	render: ->
		<div className="small-9 columns">
			{ @props.data.name}
		</div>

module.exports = ApartmentInfo