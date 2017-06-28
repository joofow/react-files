OpenNewBuildingCard = React.createClass
	displayName: "OpenNewBuildingCard"
	_handleClick: ->
		@props.closeDown()
	render: ->
		<div onClick={ @_handleClick }>
			<i className="fa fa-plus"></i>
		</div>

module.exports = OpenNewBuildingCard