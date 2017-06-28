ElementBox =  React.createClass
	displayName: 'ElementBox'

	clickedElement: ->
		@props.click(@props.data.id)

	render: ->
		<li onClick={@clickedElement}>
			<div className={@props.classes}>
				{@props.data[@props.lookup]}
			</div>
		</li>

module.exports = ElementBox