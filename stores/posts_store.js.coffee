AppDispatcher = require('../dispatcher/appdispatcher.js.coffee')
EventEmitter = require('events').EventEmitter
AppConstants = require('../constants/appConstants.js.coffee')
assign = require('object-assign')

CHANGE_EVENT = 'change'

actions = AppConstants.ActionTypes
_posts = []
_archive = []
_archive_ids = []
_posts_ids = []
_step = 1
_options = []
_apartments = []
_new_post_proto =
 audience_type: null
 audience_id: null
 from: null
 to: null
 message: null
 acknowledgement: null
 type: 'Complaint'
_new_post = jQuery.extend(true, {}, _new_post_proto)

update_post_array_if_necessary = (msg) ->
 # first check which array it is in currently
 pos = _posts_ids.indexOf(msg.id)
 archive = false
 if pos == -1
  pos = _archive_ids.indexOf(msg.id)
  if pos != -1
    archive = true
  else
    _posts.unshift msg
    _posts_ids.unshift msg.id
    return true
 # then determine which one it should go in
 posts = (new Date(msg.display_to_date) > new Date) && !msg.archive
 current = if archive then _archive[pos] else _posts[pos]
 # then check if its already updated by another action
 if current.updated_at == msg.updated_at
  return false
 # then drop it into the correct bucket
 if posts && archive
  _archive.splice pos,1   
  _archive_ids.splice pos,1
  _posts.unshift msg
  _posts_ids.unshift msg.id
 else if posts && !archive
  _posts.splice pos,1
  _posts_ids.splice pos,1
  _posts.unshift msg
  _posts_ids.unshift msg.id
 else if archive && !posts
  _archive.splice pos,1
  _archive_ids.splice pos,1
  _archive.unshift msg
  _archive_ids.unshift msg.id
 else if !archive && !posts
  _posts.splice pos,1
  _archive.unshift msg
  _posts_ids.splice pos,1
  _archive_ids.unshift msg.id
 # return true if any changes were made or false if no changes were necessary
 return true

PostsStore = assign {}, EventEmitter.prototype,
 
 getPosts: ->
  _posts
 getArchive: ->
  _archive
 getStepInNewPost: ->
  _step
 getNewPost: ->
  _new_post
 getNewOptions: ->
  _options
 getApartments: ->
  _apartments
 getCurrentBuildingFeed: ->
  current_feed = []
  _posts.map (feed) ->
    if feed.building_id == _active_id
      current_feed.push feed
    else
  current_feed
 emitChange: (newevent = CHANGE_EVENT) ->
  @emit(newevent)
 addChangeListener: (change_event, callback) ->
  @on change_event, callback
 removeChangeListener: (change_event, callback) ->
  @removeListener change_event, callback

PostsStore.dispatchToken = AppDispatcher.register (payload) ->
 action = payload.action
 switch action.type
  when actions.RECEIVED_POSTS
   if action.errors
    _error.push action.errors
   if action.data
    action.data.map (post) ->
     if ((new Date(post.display_to_date) > new Date) && !post.archive)
      _posts.push post
      _posts_ids.push post.id
     else
      _archive.push post
      _archive_ids.push post.id
   PostsStore.emitChange()
   break
  when actions.CHOSEN_AUDIENCE_TYPE
   _new_post.audience_type = action.data
   if _new_post.audience_type == 'portfolio'
    _step = 4
   else
    _step = 2
   PostsStore.emitChange('new_posts')
   break
  when actions.CHOSEN_AUDIENCE_ID
   _new_post.audience_id = action.data
   if _new_post.audience_type == 'building'
    _step = 4
   else
    _step = 3
   PostsStore.emitChange('new_posts')
   break
  when actions.RECEIVED_DIRECTORY
   if action.data && _step == 3
    _apartments = []
    action.data.map (apt) ->
     _apartments.push apt
   PostsStore.emitChange('new_posts')
   break
  when actions.CHANGE_AUDIENCE_ID
   _new_post.audience_id = action.data
   _step = 4
   PostsStore.emitChange('new_posts')
   break
  when actions.UPDATE_ACKNOWLEDGEMENT
   _step = 5
   _new_post = action.data
   PostsStore.emitChange('new_posts')
   break 
  when actions.CREATED_NEW_POST
   _step = 1
   _apartments = []
   _new_post = jQuery.extend(true, {}, _new_post_proto)
   PostsStore.emitChange('close_new_post')
   break
  when actions.RECEIVED_POST
   if action.data && action.data.hasOwnProperty('body')
   else if action.data && !action.data.hasOwnProperty('body') 
    if update_post_array_if_necessary action.data
     PostsStore.emitChange()
    else
     console.log 'there was a duplicate'
   else
    console.log 'There was an error' + action.error
  when actions.CREATED_POST
   _posts.push action.data
   PostsStore.emitChange()
   break
  when actions.CLEAR_NEW_POST
   _step = 1
   _apartments = []
   _new_post = jQuery.extend(true, {}, _new_post_proto)
   PostsStore.emitChange('close_new_post')
   break
  when actions.CHANGE_POST_STATUS
   if action.data
    console.log 'there was a duplicate'
   else
    console.log 'There was an error' + action.error
  when actions.UPDATED_POST
   if action.data
    if update_post_array_if_necessary action.data
     PostsStore.emitChange()
    else
     PostsStore.emitChange()
   else
    console.log 'There was an error' + action.error
  when actions.UPDATE_POST
   console.log 'updating...'
module.exports = PostsStore