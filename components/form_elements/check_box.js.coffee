CheckBox = React.createClass
	displayName: 'CheckBox'

	getInitialState: ->
		value: if typeof @props.value == 'undefined' && @props.value == null then false else (if @props.value && @props.value == "false"  then false else true)

	componentWillReceiveProps: (nextProps) ->
		@setState
			value: nextProps.value

	_handleChange: (e) ->
		@props.deliver_to_parent !@state.value

	render: ->
		<div>
			{@props.label}
			<input type='checkbox' onChange={@_handleChange} checked={@state.value} />
		</div>
module.exports = CheckBox