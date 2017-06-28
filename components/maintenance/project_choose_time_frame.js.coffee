DateChooser = require('../utilities/date_chooser.js.coffee')
SubmitButton = require('../form_elements/submit_button.js.coffee')

ProjectChooseTimeFrame = React.createClass
	displayName: 'ProjectChooseTimeFrame'
	getInitialState: ->
		to: ''
		from: ''
	
	_updateState: (data) ->
		if data.name == 'to'
			@setState
				to: data.value
				from: @state.from
		else
			@setState
				from: data.value
				to: @state.to

	_grabDateValues: ->
		data =
			from: @state.from
			to: @state.to
		@props.updateDates data

	render: ->
		<div className={'small-8 small-offset-2 columns ' + @props.visible }>
			<h4>Note should be shown</h4>
			<div className='row'>
				<div className='small-6 columns'>
					<DateChooser name='from' label='From' return_value={@_updateState} />
				</div>
				<div className='small-6 columns'>
					<DateChooser name='to' label='To' return_value={@_updateState} />
				</div>
			</div>
			<div className='row'>
				<SubmitButton classes='tsk' offset='9' text='apply' next={@_grabDateValues} />
			</div>
		</div>

module.exports = ProjectChooseTimeFrame