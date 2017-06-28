DateChooser = require('../utilities/date_chooser.js.coffee')
TimeChooser = require('../utilities/time_chooser.js.coffee')
SubmitButton = require('../form_elements/submit_button.js.coffee')

ProjectStart = React.createClass
	displayName: 'ProjectStart'

	getInitialState: ->
		date: ''
		time: ''
		status: 'Waiting to Schedule'
		action: true

	_submit_changes: ->
		data =
			status: @state.status
			actions:
				target_date: @state.date + " " + @state.time
				action_type: 'Started'
		@props.submit_update data

	_update_status: (val) ->
		@setState
			date: if val['name'] == 'date' then val['value'] else @state.date
			time: if val['name'] == 'time' then val['value'] else @state.time

	render: ->
		sizes = {small: 4, medium: 4, large: 4}
		<div>
			<DateChooser name={'date'} label={'What date would you like to schedule this for?'} return_value={@_update_status} sizes={sizes}/>
			<TimeChooser name={'time'} label={'What time would you like to schedule this for?'} return_value={@_update_status} sizes={sizes}/>
			<SubmitButton classes='row' next={@_submit_changes} offset='8' text='Save'/>			
		</div>
module.exports = ProjectStart