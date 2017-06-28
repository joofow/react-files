# @cjsx React.DOM

PersonItem = React.createClass

	render: ->
		<div className="people-item" id={@props.data.id}>
			{
				if @props.data
					@props.data.first_name
				else
					"No Name"
			}
		</div>

module.exports = PersonItem