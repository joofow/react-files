SectionHeader = require('../utilities/section_header.js.coffee')
PostsStore = require('../../stores/posts_store.js.coffee')
PostSummary = require('./post_summary.js.coffee')
PostChooseAudienceType = require('./post_choose_audience_type.js.coffee')
PostChooseAudience = require('./post_choose_audience.js.coffee')
PostChooseTimeFrame = require('./post_choose_time_frame.js.coffee')
PostMessage = require('./post_message.js.coffee')
PostNeedAcknowledgement = require('./post_need_acknowledgement.js.coffee')
PostViewActions = require('../../actions/posts_view_actions.js.coffee')
PostConfirmation = require('../posts/post_confirmation.js.coffee')
update = require('react-addons-update')
PostStatus = require('./post_status.js.coffee')
createFragment = require('react-addons-create-fragment')

setNewState = ->
	new_post: PostsStore.getNewPost()
	step: PostsStore.getStepInNewPost()
	options: PostsStore.getNewOptions()
	apartments: PostsStore.getApartments()

NewPostController = React.createClass
	displayName: 'NewPostController'

	getInitialState: ->
		setNewState()

	componentDidMount: ->
		PostsStore.addChangeListener 'new_posts', @_onChange
		PostsStore.addChangeListener 'close_new_post', @_closeNewPost

	componentWillUnmount: ->
		PostsStore.removeChangeListener 'new_posts', @_onChange
		PostsStore.removeChangeListener 'close_new_post', @_closeNewPost

	shouldComponentUpdate: (nextProps,nextState) ->
		true

 _closeNewPost: ->
  @props.close_new_post()
  @setState setNewState()

 _clearNewPost: ->
  PostViewActions.clearNewPost()

	_onChange: ->
		@setState setNewState()

	_chosen_audience_type: (type) ->
		PostViewActions.chosenAudienceType type

	_chosen_building_target: (id) ->
		if @state.step == 2
			PostViewActions.chosenAudienceId id
		else if @state.step == 3
			PostViewActions.changeAudienceId id

	_update_dates: (data) ->
		new_post = if data['name'] == 'from'
			update(@state.new_post,{from: {$set: data['value']}})
		else
			update(@state.new_post,{to: {$set: data['value']}})
		@setState
			new_post: new_post

	_change_acknowledge: (data) ->
		@setState
			new_post: update(@state.new_post,{acknowledgement: {$set: data}})

	_submit_post: ->
		PostViewActions.createNewPost @state.new_post

 _update_message: (data) ->
		@setState
			new_post: update(@state.new_post,{message: {$set: data}})

 _submit_new_post: ->
 	PostViewActions.confirmFinal @state.new_post

 _update_status: (data) ->
 	console.log data
		@setState
			new_post: update(@state.new_post,{type: {$set: data}})

	render: ->
		<div className={ if @props.open then 'll-new-property' else 'hide'}>
			<SectionHeader title='New Post' exit={@_clearNewPost} />
			createFragment
				one: <PostSummary data={@state.new_post} visible={ if [1,2,3,4,5,6,7].indexOf(@state.step) > -1 then 'visible' else 'hide' } />
				two: <PostChooseAudienceType data={@state.new_post} typeChoosen={@_chosen_audience_type} visible={ if [1].indexOf(@state.step) > -1 then 'visible' else 'hide' } />
				three: <PostChooseAudience apartments={@state.apartments} step={@state.step} idChoosen={@_chosen_building_target} data={@state.new_post} visible={ if [2,3].indexOf(@state.step) > -1 then 'visible' else 'hide' } people={@props.people} buildings={@props.buildings} />
				four: <PostMessage value={@state.new_post.message} visible={ if [4].indexOf(@state.step) > -1 then 'visible' else 'hide' } submit_message_text={@_update_message} />
				five: <PostStatus update_status={@_update_status} visible={ if [4].indexOf(@state.step) > -1 then 'visible' else 'hide' } />
				six: <PostChooseTimeFrame updateDates={@_update_dates} data={@state.new_post} visible={ if [4].indexOf(@state.step) > -1 then 'visible' else 'hide' } />
				seven: <PostNeedAcknowledgement submit_new_post={@_submit_new_post} data={@state.new_post} visible={ if [4].indexOf(@state.step) > -1 then 'visible' else 'hide' } need_to_acknowledge={@_change_acknowledge} />
				eight: <PostConfirmation data={@state.new_post} visible={ if [5].indexOf(@state.step) > -1 then 'visible' else 'hide' } confirmed={@_submit_post} />
		</div>
module.exports = NewPostController