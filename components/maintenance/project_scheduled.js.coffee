ContentEditable = require('../utilities/content_editable.js.coffee')
CheckBox = require('../form_elements/check_box.js.coffee')
SubmitButton = require('../form_elements/submit_button.js.coffee')

ProjectScheduled = React.createClass
	displayName: 'ProjectScheduled'

	getInitialState: ->
		html: ''
		action: 'Completed'
		done: false
	
	_updatedStatus: (val) ->
		@setState
			done: !@state.done
			html: @state.html

	_changeHandler: (e) ->
		@setState
			html: e.target.value
	
	_submit_changes: ->
		data =
			actions:
				description: @state.html
				action_type: @props.current
			status: @state.action
		if @state.done
			@props.submit_update data
		else
			console.log('And here we add error handling')

	render: ->
		<div>
			<ContentEditable ref="message" html={@state.html} onChange={@_changeHandler} className='content-editable' />
			<CheckBox deliver_to_parent={@_updatedStatus} label='Mark as Completed?'/>
			<SubmitButton classes='row' next={@_submit_changes} offset='8' text='Save'/>			
		</div>
module.exports = ProjectScheduled