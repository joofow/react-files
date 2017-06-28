# @cjsx React.DOM
PeopleViewActions = require('../../actions/people_view_actions.js.coffee')

PersonMenuItem = React.createClass
	displayName: "MenuItem"

	open: ->
		# PeopleViewActions[@props.hash]
		@props.click()
		switch @props.hash
			when 'startNewConversation'
				PeopleViewActions.startNewConversation(@props.id)
			when 'makeNewPayment'
				PeopleViewActions.makeNewPayment(@props.id)
			when 'assignNewTask'
				PeopleViewActions.assignNewTask(@props.id)
			when 'sendNewReminder'
				PeopleViewActions.sendNewReminder(@props.id)

	render: ->
		cx = React.addons.classSet
		cardClasses = cx
			pay: @props.hash == 'makeNewPayment'
			task: @props.hash == 'assignNewTask'
			reminder: @props.hash == 'sendNewReminder'
			message: @props.hash == 'startNewConversation'
		<div className={cardClasses+"-logo small-3 columns"} onClick={@open}>
			{@props.children}
		</div>

module.exports = PersonMenuItem