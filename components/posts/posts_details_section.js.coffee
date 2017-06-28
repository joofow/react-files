PostFeedCard = require('./post_feed_card.js.coffee')
PostViewActions = require('../../actions/posts_view_actions.js.coffee')

PostsDetailsSection = React.createClass
	displayName: 'PostsDetailsSection'

	_change_status: (action, id) ->
		PostViewActions.changeStatus action, id

	render: ->
		if (@props.people?) && (@props.data? && @props.data.length > 0)
			cards = ((<PostFeedCard archive={ @props.archive } change_status={@_change_status} buildings={@props.buildings} apartments={@props.apartments} data={post} key={'post_card_' + post.id} people={@props.people} person={if post.post_target_type == 'Person' then @props.people[post.post_target_id] else @props.people[post.person_id]}/>) for post in @props.data)
		<div className='row posts-section'>
			<div className='medium-12 columns' data-cssid='posts-main-feed'>
				{
					if cards?
					else
						"No posts here!"
					}
			</div>
		</div>

module.exports = PostsDetailsSection