FeedStore = require('../../stores/feed_store.js.coffee')
FeedViewActions = require('../../actions/feed_view_actions.js.coffee')
ShortTaskCard = require('../tasks/short_task_card.js.coffee')
EmptyTaskCard = require('../utilities/empty_task_card.js.coffee')

getFeed = ->
	tasks: FeedStore.getFeed()

RecentTasksSection = React.createClass
	displayName: "RecentTasks"

	getInitialState: ->
		tasks: []

	componentDidMount: ->
		FeedViewActions.getInitialFeed()
		FeedStore.addChangeListener(@_onChange)
		FeedViewActions.filterView 'Task'	

	_onChange: ->
		@setState getFeed()

	render: ->
		$tasks = @state.tasks
		tasks = $tasks[0..4].map (task) ->
			<ShortTaskCard data={task} />
		if tasks.length == 0
			tasks = <EmptyTaskCard />
		<div>{tasks}</div>

module.exports = RecentTasksSection
