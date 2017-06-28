OpenNewRequestCard = React.createClass
	displayName: "OpenNewRequestCard"
	_handleClick: ->
		@props.closeDown()
	render: ->
		<div onClick={ @_handleClick }>
			<i className="fa fa-plus"></i>
		</div>

module.exports = OpenNewRequestCard