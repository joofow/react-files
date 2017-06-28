TimeAgo = require('../../utils/timeago.js.coffee')
PersonAvatar = require('../people/person_avatar.js.coffee')
NotifactionCard = require('../utilities/notification_card.js.coffee')
LikeCard = require('../utilities/like_card.js.coffee')

PaymentFeedCard = React.createClass
	displayName: 'PaymentFeedCard'

	_nowActive: ->
		@props.click @props.data.id

	render: ->
		<div className='row panel'>
			<div className='small-2 columns'>
				<PersonAvatar data={@props.person} />
				<div className='d-smaller'>{@props.person.first_name + ", " + @props.person.last_name}
				</div>
			</div>
			<div className='small-9 columns'>
				<div className='row'>
					<div className='smaller-12 columns'>
						{
							@props.data.description
						}
					</div>
				</div>
				<div className='row'>
					<div className='small-12 columns social-interactions'>
					</div>
				</div>
			</div>
			<div className='small-1 columns'><TimeAgo time={@props.data.updated_at} /></div>
		</div>

module.exports = PaymentFeedCard