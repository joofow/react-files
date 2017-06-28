NewPaymentCard = require('../payments/new_payment_card.js.coffee')
NewConversationCard = require('../conversations/new_conversation_card.js.coffee')
NewTaskCard = require('../tasks/new_task_card.js.coffee')
NewReminderCard = require('../reminders/new_reminder_card.js.coffee')
createFragment = require('react-addons-create-fragment')

NewActionCard = React.createClass
	displayName: 'NewActionCard'

	_closingTime: ->
		@props.closing()

	render: ->
		visibility = if @props.visible then 'new-action' else 'hide'
		type = switch @props.data.type
			when 'payment' then createFragment one: <NewPaymentCard data={@props.data} close={@_closingTime}/>
			when 'task' then createFragment two: <NewTaskCard data={@props.data} close={@_closingTime} />
			when 'reminder' then createFragment three: <NewReminderCard data={@props.data} close={@_closingTime} update={@_updateTime} />
			when 'message' then createFragment four: <NewConversationCard data={@props.data} close={@_closingTime} />
		<div className={visibility}>
			{ type }
		</div>

module.exports = NewActionCard