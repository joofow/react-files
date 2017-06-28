#	@cjsx	React.DOM		
FeedStore	=	require('../../stores/feed_store.js.coffee')
FeedCard	=	require('./feed_card.js.coffee')
FeedViewActions = require('../../actions/feed_view_actions.js.coffee')

getFeedComponents	=	->
	people: FeedStore.getPeople()
	feed:	FeedStore.getFeed()

FeedSection	=	React.createClass
	displayName: "FeedSection"

	getInitialState:	->
		getFeedComponents()

	componentDidMount:	->
		FeedStore.addChangeListener(@_onChange)
		FeedViewActions.getInitialFeed()
	
	componentDidUpdate: ->

	_onChange:	->
		@setState	getFeedComponents()

	render:	->
		$people = @state.people
		$feed = @state.feed
		feedNode	=	$feed.map (feed_key) ->
			<FeedCard	avatar={$people} data={feed_key} key={feed_key.key} />
		<div className="small-12 columns">{feedNode}</div>

module.exports	=	FeedSection