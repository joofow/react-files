TextInput = require('../form_elements/text_input.js.coffee')
DateChooser = React.createClass
	displayName: 'DateChooser'
	_date_input: ->
		data =
			name: @props.name
			value: @refs[@props.name].state.value || ''
		@props.return_value data
	render: ->
		<TextInput input_type='date' initial_value={@props.cur_val} label={@props.label} sizes={@props.sizes} labelClass="right inline" deliver_to_parent={@_date_input}/>
module.exports = DateChooser