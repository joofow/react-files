SubmitButton = require('../form_elements/submit_button.js.coffee')
EditText = require('../form_elements/edit_text.js.coffee')
EditDate = require('../form_elements/edit_date.js.coffee')
EditSelect = require('../form_elements/edit_select.js.coffee')

ProjectEditSection = React.createClass
	displayName: 'ProjectEditSection'

	getInitialState: ->
		description: @props.data.description
		display_to_date: @props.data.display_to_date
		status: @props.data.status
		purpose: @props.data.purpose

	_submit_changes: ->
		@props._submit_update @state

	_update_val: (hash) ->
		@setState hash	
	
	_submit_changes: (state) ->
		@props.update_card @state

	render: ->
		edits = []
		for key,value of @props.data
			if ['description','display_to_date','status','purpose'].indexOf(key) > -1
				edits.push switch key
					when 'description' then <div className='row'><EditText currentkey={key} currentvalue={value} change_val={@_update_val} /></div>
					when 'display_to_date' then <div className='row'><EditDate currentkey='To' currentvalue={value} change_val={@_update_val} /></div>
					when 'status' then <div className='row'><EditSelect change_val={@_update_val} currentkey={key} currentvalue={value} dataset={[{value: "complaint", name: "Complaint"},{value: "delivery", name: "Delivery"},{value: "maintenance", name: "Maintenance"},{value: "information", name: "Information"},{value: "other", name: "Other"}]} /></div>
					when 'purpose' then <div className='row'><EditSelect change_val={@_update_val} currentkey={key} currentvalue={value} dataset={[{value: 'Post', name:'Post'},{name:'Task',value:'Task'}]} /></div>
		<div className='post-edit-section'>
			{ edits }
			<SubmitButton classes='row' next={@_submit_changes} offset='8' text='Save'/>			
		</div>
module.exports = ProjectEditSection