ToggleBox = React.createClass
	displayName: 'ToggleBox'

	render: ->
		classes = if @props.visibility
			' open'
		else
			' hide'
		<ul className={@props.classes + classes}>
			{@props.children}
		</ul>

module.exports = ToggleBox