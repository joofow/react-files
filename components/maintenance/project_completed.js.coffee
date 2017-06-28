ContentEditable = require('../utilities/content_editable.js.coffee')
CheckBox = require('../form_elements/check_box.js.coffee')
SubmitButton = require('../form_elements/submit_button.js.coffee')

ProjectCompleted = React.createClass
	displayName: 'ProjectCompleted'

	getInitialState: ->
		html: ''
		action: 'Completed'
		done: false
	
	_submit_changes: ->
		data = 
			status: @state.action
			actions: 
				description: @state.html
				action_type: @state.status

	_updatedStatus: (val) ->
		@setState
			done: !@state.done

	render: ->
		<div>
			<ContentEditable ref="message" html={@state.html} onChange={@changeHandler} className='content-editable' />
			<CheckBox deliver_to_parent={@_updatedStatus} label='Mark as Completed?'/>
			<SubmitButton classes='row' next={@_submit_changes} offset='8' text='Save'/>			
		</div>
module.exports = ProjectCompleted