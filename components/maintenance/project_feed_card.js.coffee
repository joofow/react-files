TimeAgo = require('../../utils/timeago.js.coffee')
PersonAvatar = require('../people/person_avatar.js.coffee')
NotifactionCard = require('../utilities/notification_card.js.coffee')
LikeCard = require('../utilities/like_card.js.coffee')
ContentEditable = require('../utilities/content_editable.js.coffee')
SubmitButton = require('../form_elements/submit_button.js.coffee')
ProjectActionButtons = require('./project_action_buttons.js.coffee')
ProjectEditSection = require('./project_edit_section.js.coffee')
update = require('react-addons-update')
MessageSection = require('../messages/messages_section.js.coffee')
MessageStore = require('../../stores/message_stores.js.coffee')
ProjectViewActions = require('../../actions/project_view_actions.js.coffee')
ProjectStart = require('./project_start.js.coffee')
ProjectWaiting = require('./project_waiting.js.coffee')
ProjectScheduled = require('./project_scheduled.js.coffee')
ProjectCompleted = require('./project_completed.js.coffee')
ProjectCandC = require('./project_candc.js.coffee')

ProjectFeedCard = React.createClass
	displayName: 'ProjectFeedCard'
	getInitialState: ->
		actions: false
		active_response: false
		shorten: false
		no_messages: MessageStore.getNoMessages 'Project', @props.data.id
		edit_project: false
		next_action: false

	componentDidMount: ->
 	MessageStore.addChangeListener @_new_messages, "Project", @props.data.id

 componentWillUnmount: ->
  MessageStore.removeChangeListener @_new_messages, "Project", @props.data.id    
  
 _new_messages: ->
  @setState 
   no_messages: update(@state.no_messages,{$apply: (x) -> x+1 })

	_createMarkup: ->
		a = @_get_msg_array()
		{ __html: if !@state.shorten && (a[0].length > 100 || a.length > 2) then a[0][0..96] + "..." else @props.data.description }

	_get_msg_array: ->
		if @props.data.description == null
			[""]
		else
			@props.data.description.split('<div>') 
	
	_expand_project: ->
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

	_edit: ->
		@setState
			edit_project: !@state.edit_project

	_start_new_action: ->
		@setState
			next_action: !@state.next_action

	_submit_update: (value) ->
		ProjectViewActions.updateProject @props.data.id, value

	render: ->
		data = @props.data
		target = @props.target
		status = switch @props.data.status
			when 'Started' then 'Schedule'
			when 'Waiting to Schedule' then 'Re-schedule'
			when 'Completed' then 'Confirm'
			when 'Scheduled' then 'Complete'
			when 'Confirmed & Completed' then 'Change status'
		target = target.filter (n) -> 
			return n != undefined
		target = switch data.project_target_type
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
		a = @_get_msg_array()
		shorten = a[0].length > 100 || (a.length > 1 && a[0].length + a[1].length > 100) || a.length > 2
		<div className='panel row'>
			<div className='small-12 columns'>
				<div className='row'>
					<div className={'project-main columns ' + if @state.actions then 'small-8' else 'small-12'}>
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
							<div className='small-2 columns project-avatar'>
								{ 
									if @props.project_target_type == 'Person'
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
											<span className='expand-project' onClick={@_expand_project}>See More</span>
									}
							</div>
						</div>
						<div className='row' onClick={@_activate_messages}>
							<div className={'small-centered columns project-interactions text-center ' + if @state.actions then 'small-7' else 'small-6' }>
								<div className='row'>
									<div className={'project-type small-6 columns ' + color}>
										{ @props.data.status || 'NONE'}
									</div>
									<div className='project-social small-6 columns'>
										<div className={'project-notifications ' + info }>
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
						<ProjectActionButtons status={@props.data.archive} key={'project' + @props.data.id} active={@state.actions} respond={@_activate_messages} archive={@_archive} edit={@_edit} next_action={status} start_next_action={@_start_new_action} />
					</div>
				</div>
				<div className={'row ' + if @state.active_response then '' else 'hide'}>
					<div className='small-12 columns'>
						<MessageSection people={@props.people} id={@props.data.id} type='Project' />
					</div>
				</div>
				<div className={'row ' + if @state.edit_project then '' else 'hide'}>
					<div className='small-12 columns'>
						<ProjectEditSection data={@props.data} id={@props.data.id} type='Project' update_card={@_submit_update} />
					</div>
				</div>
				<div className={'row ' + if @state.next_action then '' else 'hide'}>
					<div className='small-12 columns'>
						{
							switch @props.data.status
								when 'Started' then <ProjectStart submit_update={@_submit_update} current={@props.data.status}/>
								when 'Waiting to Schedule' then <ProjectWaiting submit_update={@_submit_update} current={@props.data.status}/>
								when 'Completed' then <ProjectCompleted submit_update={@_submit_update} current={@props.data.status}/>
								when 'Scheduled' then <ProjectScheduled submit_update={@_submit_update} current={@props.data.status}/>
								when 'Confirmed & Completed' then <ProjectCandC submit_update={@_submit_update} current={@props.data.status}/>
							}
					</div>
				</div>
			</div>
		</div>
module.exports = ProjectFeedCard