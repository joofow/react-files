TimeAgo = require('../../utils/timeago.js.coffee')
PersonAvatar = require('../people/person_avatar.js.coffee')
NotifactionCard = require('../utilities/notification_card.js.coffee')
LikeCard = require('../utilities/like_card.js.coffee')

BuildingFeedCard = React.createClass
	displayName: 'BuildingFeedCard'

	_nowActive: ->
		@props.click @props.data.id

	render: ->
		<div className='row panel'>
			<div className='small-2 columns'>
				<PersonAvatar data={@props.data} />
				<div className='d-smaller'>{@props.data.people_in_conversations[0].person.first_name + ", " + @props.data.people_in_conversations[0].person.last_name[0]}
				</div>
			</div>
			<div className='small-9 columns'>
				<div className='row'>
					<div className='smaller-12 columns'>
						{
							if @props.data.payments.length 
								@props.data.payments[0].description
							else if @props.data.requests.length
								@props.data.requests[0].description
							else if @props.data.reminders.length
								@props.data.reminders[0].description
							else if @props.data.tasks.length
								@props.data.tasks[0].description
							else if @props.data.notices.length
								@props.data.notices[0].description
						}
					</div>
				</div>
				<div className='row'>
					<div className='small-12 columns social-interactions'>
						{
							if @props.data.total_notifications == 0
								<NotifactionCard data={@props.data.total_notifications} />
						}
						{
							if @props.data.total_likes == 0
								<LikeCard data={@props.data.total_likes} />
						}
					</div>
				</div>
			</div>
			<div className='small-1 columns'><TimeAgo time={@props.data.updated_at} /></div>
		</div>

module.exports = BuildingFeedCard