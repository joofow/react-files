DateChooser = require('../utilities/date_chooser.js.coffee')
SubmitButton = require('../form_elements/submit_button.js.coffee')
PostChooseTimeFrame = React.createClass
	displayName: 'PostChooseTimeFrame'
	
	_updateState: (data) ->
		@props.updateDates data

	render: ->
		sizes = {small: 7, medium: 7, large: 7}
		<div className={'post-element small-8 small-offset-2 columns ' + @props.visible }>
			<div className='row'>
				<div className='small-6 columns'>
					<DateChooser name='from' label='Display From' cur_val={@props.data.from} return_value={@_updateState} sizes={sizes}/>
				</div>
				<div className='small-6 columns'>
					<DateChooser name='to' label='Display To' cur_val={@props.data.to} return_value={@_updateState} sizes={sizes}/>
				</div>
			</div>
		</div>
module.exports = PostChooseTimeFrame