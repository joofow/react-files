#	@cjsx	React.DOM		
FeedViewActions = require('../../actions/feed_view_actions.js.coffee')

FeedControls = React.createClass
	displayName: "FeedControls"

	_payments: ->
		FeedViewActions.filterView 'Payment'
	_tasks: ->
		FeedViewActions.filterView 'Task'
	_reminders: ->
		FeedViewActions.filterView 'Reminder'
	render: ->
		<div>
			<span className="pay-logo" onClick={@_payments}></span>
			<span className="task-logo" onClick={@_tasks}></span>
			<span className="reminder-logo" onClick={@_reminders}></span>
		</div>

module.exports = FeedControls