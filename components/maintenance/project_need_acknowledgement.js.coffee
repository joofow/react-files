CheckBox =  require('../form_elements/check_box.js.coffee')
SubmitButton = require('../form_elements/submit_button.js.coffee')

ProjectNeedAcknowledgement = React.createClass
	displayName: 'ProjectNeedAcknowledgement'
	getInitialState: ->
		value: false
	
	componentWillReceiveProps: (nextProps) ->
		if nextProps.data.acknowledgement == null
			@setState value: false

	_need_to_acknowledge: (data) ->
		@setState
			value: data

	_submit_upstream: ->
		@props.need_to_acknowledge @state.value

	render: ->
		sizes = {small: 9, medium: 9, large: 9}
		<div className={'small-8 small-offset-2 columns ' + @props.visible }>
			<CheckBox label='Tenants need to acknolwedge' value={@state.value} sizes={sizes} labelClass="right inline" deliver_to_parent={@_need_to_acknowledge} />
			<SubmitButton offset='7' text='Apply' next={@_submit_upstream} classes='row' />
		</div>

module.exports = ProjectNeedAcknowledgement