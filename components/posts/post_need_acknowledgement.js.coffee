CheckBox =  require('../form_elements/check_box.js.coffee')
SubmitButton = require('../form_elements/submit_button.js.coffee')

PostNeedAcknowledgement = React.createClass
	displayName: 'PostNeedAcknowledgement'

	getInitialState: ->
		value: false

	componentWillReceiveProps: (nextProps) ->
		if JSON.parse(nextProps.data.acknowledgement) != @state.value
			@setState
				value: JSON.parse(nextProps.data.acknowledgement)
	shouldComponentUpdate: (nextProps,nextState) ->
		if (nextState.value == @state.value) && nextProps.visible == @props.visible
			false
		else
			true

	_need_to_acknowledge: (data) ->
		@props.need_to_acknowledge data

	_submit_upstream: ->
		@props.submit_new_post()

	render: ->
		sizes = {small: 9, medium: 9, large: 9}
		<div className={'small-8 small-offset-2 columns ' + @props.visible }>
			<CheckBox label='Tenants to acknowledge?' value={@state.value} sizes={sizes} labelClass="right inline" deliver_to_parent={@_need_to_acknowledge} />
			<SubmitButton offset='7' text='Submit' next={@_submit_upstream} classes='row' />
		</div>
module.exports = PostNeedAcknowledgement