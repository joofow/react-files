TimeAgo = require('../../utils/timeago.js.coffee')
PersonAvatar = require('../people/person_avatar.js.coffee')
NotifactionCard = require('../utilities/notification_card.js.coffee')
LikeCard = require('../utilities/like_card.js.coffee')
PostActionButtons = require('./post_action_buttons.js.coffee')
MessageSection = require('../messages/messages_section.js.coffee')
MessageStore = require('../../stores/message_stores.js.coffee')
PostEditSection = require('./post_edit_section.js.coffee')
update = require('react-addons-update')
PostViewActions = require('../../actions/posts_view_actions.js.coffee')

PostFeedCard = React.createClass
	displayName: 'PostFeedCard'

	getInitialState: ->
		actions: false
		active_response: false
		shorten: false
		no_messages: MessageStore.getNoMessages 'Post', @props.data.id
		edit_post: false

	componentDidMount: ->
 	MessageStore.addChangeListener @_new_messages, "Post", @props.data.id

 componentWillUnmount: ->
  MessageStore.removeChangeListener @_new_messages, "Post", @props.data.id    
  
 _new_messages: ->
  @setState 
   no_messages: update(@state.no_messages,{$apply: (x) -> x+1 })

	_createMarkup: ->
		a = @props.data.description.split('<div>')
		{ __html: if !@state.shorten && (a[0].length > 100 || a.length > 2) then a[0][0..96] + "..." else @props.data.description }

	_expand_post: ->
		@setState
			shorten: !@state.shorten
	
	_nowActive: ->
		@props.click @props.data.id

	_request_info: ->
		console.log('check')

	_open_actions: ->
		@setState
			actions: !@state.actions

	_activate_messages: ->
		@setState
			active_response: !@state.active_response

	_archive: (action) ->
		@props.change_status action, @props.data.id

	_edit: ->
		@setState
			edit_post: !@state.edit_post

	_submit_update: (value) ->
		PostViewActions.updatePost @props.data.id, value

	render: ->
		data = @props.data
		target = switch data.post_target_type
			when 'Building'
				@props.buildings.map (b) ->
					if data.post_target_id == b.id
						b
			when 'Apartment'
				@props.apartments.map (a) ->
					if data.post_target_id == a.id
						a
			when 'Person'
				[@props.person]
			when 'Landlord'
				['All Properties']
		target = target.filter (n) -> 
			return n != undefined
		target = switch data.post_target_type
			when 'Person'
				target[0].first_name + ", " + target[0].last_name
			when 'Building'
				target[0].address_line_1
			when 'Apartment'
				target[0].name
			when 'Landlord'
				target[0]
		switch @props.data.status
			when 'complaint', 'Complaint'
				color = 'alert-red'
				info = ''
			else 
				color = 'alert-green'
				info = 'alert-info'
		a = @props.data.description.split('<div>')
		shorten = a[0].length > 100 || (a.length > 1 && a[0].length + a[1].length > 100) || a.length > 2
		<div className='panel row'>
			<div className='small-12 columns'>
				<div className='row'>
					<div className={'post-main columns ' + if @state.actions then 'small-8' else 'small-12'}>
						<div className='row' onClick={@_open_actions}>
							<div className={'columns ' + if @state.actions then 'small-9' else 'small-11'}>
								<div className='d-smaller'>
									{ target }
								</div>
							</div>
							<div className={'columns ' + if @state.actions then 'small-3' else 'small-1'}>
								<TimeAgo time={@props.data.updated_at} />
							</div>
						</div>
						<div className='row'>
							<div className='small-2 columns post-avatar'>
								{ 
									if @props.post_target_type == 'Person'
										<PersonAvatar data={@props.person} />
									else
										<i className='fa fa-2x fa-building'></i>
									}
							</div>
							<div className='small-10 columns end'>
								<div className='row'>
									<div className='small-10 columns end' dangerouslySetInnerHTML={@_createMarkup()} onClick={@_open_actions}>
									</div>
								</div>
								{ 
										if shorten && !@state.shorten
											<span className='expand-post' onClick={@_expand_post}>See More</span>
									}
							</div>
						</div>
						<div className='row' onClick={@_activate_messages}>
							<div className={'small-centered columns post-interactions text-center ' + if @state.actions then 'small-7' else 'small-6' }>
								<div className='row'>
									<div className={'post-type small-6 columns ' + color}>
										{ @props.data.status || 'NONE'}
									</div>
									<div className='post-social small-6 columns'>
										<div className={'post-notifications ' + info }>
											<span>
												{ @props.data.total_notifications}
											</span>
											<span>
												Views
											</span>
											<span>
												{ @state.no_messages }
											</span>
											<span>
												<i className='fa fa-comment'></i>
											</span>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div className={if @state.actions then 'small-4 columns feed-flexbox' else 'hide'}>
						<PostActionButtons status={@props.data.archive} key={'post' + @props.data.id} active={@state.actions} respond={@_activate_messages} archive={@_archive} edit={@_edit}/>
					</div>
				</div>
				<div className={'row ' + if @state.active_response then '' else 'hide'}>
					<div className='small-12 columns'>
						<MessageSection people={@props.people} id={@props.data.id} type='Post' />
					</div>
				</div>
				<div className={'row ' + if @state.edit_post then '' else 'hide'}>
					<div className='small-12 columns'>
						<PostEditSection data={@props.data} id={@props.data.id} type='Post' update_card={@_submit_update}/>
					</div>
				</div>
			</div>
		</div>

module.exports = PostFeedCard