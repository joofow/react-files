ApartmentSketchCard = React.createClass
	displayName: 'AptSketch'

	getInitialState: ->
		class_active: false

	_change_apt: ->
		@props.change_apt(@props.floor + String.fromCharCode(64 + @props.number))
		@setState
			class_active: !@state.class_active

	render: ->
		cl = if @state.class_active then 'active' else ''
		apt_number = @props.floor + String.fromCharCode(64 + @props.number)
		<div className={"sketch " + cl} onClick={@_change_apt}>
			{ apt_number }
		</div>

module.exports = ApartmentSketchCard