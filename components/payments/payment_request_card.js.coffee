PaymentViewActions = require('../../actions/payments_view_actions.js.coffee')
TaskViewActions = require('../../actions/tasks_view_actions.js.coffee')

PaymentRequestCard = React.createClass
	displayName: "PaymentRequestCard"

	getInitialState: ->
		completed: if @props.data.type.completed_date then true else false

	_updatePayment: ->
		if @props.data.type_type == "Payment"
		 PaymentViewActions.updatePayment({id: @props.data.type.id, completed: !@state.completed})
		else if @props.data.type_type == 'Task'
		 TaskViewActions.updateTask({id: @props.data.type.id, completed: !@state.completed})			
		@setState
			completed: !@state.completed
	_dropIt: (text) ->
		text.toLowerCase()
 _getDate: (date) ->
   d = new Date(date)
   d.toLocaleString("en-us", { month: "short" }) + " " + d.getDate() + ", " + d.getFullYear()
	render: ->
		cx = React.addons.classSet
		complete = if @props.data.type.completed_date then true else false
		classes = cx
			'completed': complete
			'active-reminder': @props.data.type.reminder_id
		<div className={@_dropIt(@props.data.type_type)+"-"+(classes || 'incomplete')}>
			{ 
   	if @props.data.type.reminder_id
    	"Due by " + @_getDate(Date.parse(@props.data.type.reminder.end_date))
   	else if @props.data.type.completed_date
    	"Completed on " + @_getDate(Date.parse(@props.data.type.completed_date))
  	}
			<input ref="checked" type="checkbox" onChange={@_updatePayment} checked={@state.completed}/>
		</div>

module.exports = PaymentRequestCard