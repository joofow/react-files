PersonList = require('../people/person_list.js.coffee')
ReminderActionCreators = require('../../actions/reminders_view_actions.js.coffee')
AddPeopleCard = require('../people/add_people_card.js.coffee')

NewReminderCard = React.createClass
	displayName: "NewReminderCard"

	getInitialState: ->
		recipient: (if @props.data.assigned_person_id == Array then @props.data.assigned_person_id else @props.data.assigned_person_id.toString().split(","))
		text: ''
		end_date: Date.now()

	_handleOnSubmit: (e) ->
		e.preventDefault()
		txt = @refs.reminder_text.getDOMNode().value.trim()
		date = @refs.reminder_date.getDOMNode().value.trim()
		aid = @state.recipient
		ReminderActionCreators.createReminder aid, txt, date
		@refs.reminder_text.getDOMNode().value.trim()
		@refs.reminder_date.getDOMNode().value.trim()
		@props.close()

	addAdditionalPeople: (ids) ->
		idsNew = @state.recipient
		if idsNew.indexOf(ids) > -1 then '' else idsNew.push(ids)
		@setState
			recipient: idsNew

 _changeVisibility: ->
 	@setState
 		visibility: true
 _changeVisibilityBack: ->
 	@setState
 		visibility: false

	render: ->
  visibility = if @props.data.visible
    ''
  	else
    'hide '
  <div className={ visibility + "new-reminder"}>
  	<form onSubmit={@_handleOnSubmit}>
		  <div className="people-for">
     {
       if @state.recipient
         <PersonList keys={@state.recipient} />
       else
         ""
     }
     <AddPeopleCard data={@props.data.assigned_person_id} update={@addAdditionalPeople} />
				</div>
				<div>
					<input ref="reminder_text" placeholder="Remind me about..." type="text" />
					<input ref="reminder_date" type="date" className="small-6 columns" />
				</div>
				<input type="submit" name="submit" />
			</form>
		</div>

module.exports = NewReminderCard