DateChooser = require('../utilities/date_chooser.js.coffee')
EditDate = React.createClass
	displayName: 'EditDate'
	getInitialState: ->
		editable: false

	_update_status: (val) ->
		up = {}
		up[@props.currentkey] = val
		@props.change_val up

	_edit:->
		@setState
			editable: !@state.editable

	render: ->
		date = if @state.editable
			sizes = {small: 6, medium: 6, large: 6}
			<DateChooser name={@props.currentkey} label={@props.currentkey} cur_val={@props.currentvalue} return_value={@_update_status} sizes={sizes}/>
		else
			<div className='small-6 columns' onClick={@_edit}>
				{@props.currentkey}: {@props.currentvalue}
			</div>
		<div>
			{date}
		</div>
module.exports = EditDate