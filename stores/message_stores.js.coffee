AppDispatcher = require('../dispatcher/appdispatcher.js.coffee')
EventEmitter = require('events').EventEmitter
appConstants = require('../constants/appConstants.js.coffee')
assign = require('object-assign')
PaymentsStore = require('./payments_store.js.coffee')
PostsStore = require('./posts_store.js.coffee')
ProjectsStore = require('./project_store.js.coffee')

actions = appConstants.ActionTypes

CHANGE_EVENT = 'change'

_messages = []
_post_messages_list = {}
_projects_messages_list = {}
_message = {body: "", id: "", conversation_id: "", person_id: ""}
_errors = []

create: (conversation_id, person_id, body) ->
  id = Date.now()
  _messages[id] = 
    conversation_id: conversation_id,
    person_id: person_id,
    id: id,
    body: body

sort_messages = (msg) ->
  if msg.target_type == 'Post'
    if _post_messages_list.hasOwnProperty(msg.target_id)
      unique = _post_messages_list[msg.target_id].filter (p) -> p.id == msg.id
      if unique.length > 0
        return false
      else
        _post_messages_list[msg.target_id].push msg
    else
      _post_messages_list[msg.target_id] = [msg]
  else if msg.target_type == 'Project'
    if _projects_messages_list.hasOwnProperty(msg.target_id)
      unique = _projects_messages_list[msg.target_id].filter (p) -> p.id == msg.id
      if unique.length > 0
        return false
      else
        _projects_messages_list[msg.target_id].push msg
    else
      _projects_messages_list[msg.target_id] = [msg]

MessagesStore = assign {}, EventEmitter.prototype,
  destroy: (id) ->
    delete _messages[id]
  getMessages: (type,id) ->
    if type == 'Post'
      _post_messages_list[id] || []
    else if type == 'Project'
      _projects_messages_list[id] || []
  getMessage: ->
    _message
  getErrors: ->
    _errors
  getNoMessages: (type, id) ->
    if type == 'Post'
      if _post_messages_list.hasOwnProperty(id)
        _post_messages_list[id].length
      else
        0
    else if type == 'Project'
      if _projects_messages_list.hasOwnProperty(id)
        _projects_messages_list[id].length
      else
        0
  emitChange: (id) ->
    @emit CHANGE_EVENT + id 
  addChangeListener: (callback,type,id) ->
    @on CHANGE_EVENT + type + id, callback
  removeChangeListener: (callback,type,id) ->
    @removeListener CHANGE_EVENT + type + id, callback

MessagesStore.setMaxListeners(0)

MessagesStore.dispatchToken = AppDispatcher.register (payload) ->
  action = payload.action
  switch action.type
    when actions.RECEIVED_CREATED_MESSAGE
      if action.data
        _messages.unshift(action.data)
        _errors = []
      if action.errors
        _errors = action.errors
      MessagesStore.emitChange()
      break
    when actions.RECEIVED_CONVERSATIONS
      AppDispatcher.waitFor([ConversationsStore.dispatchToken])
      AppDispatcher.waitFor([UnreadConversationsStore.dispatchToken])
      if action.data
        MessagesStore.addMessages(action.data[con].messages) for con of action.data
      if action.errors
        _errors = action.errors
      MessagesStore.emitChange()
      break
    when actions.RECEIVED_MESSAGES
      if action.data
        action.data.map (msg) ->
          sort_messages msg         
    when actions.RECEIVED_MESSAGE
      if action.data
        if sort_messages(action.data) == false
          return false
      else
        return false
      MessagesStore.emitChange (action.data.target_type + action.data.target_id.toString())
      break
    when actions.RECEIVED_POST
      if action.data.hasOwnProperty('body')
        if sort_messages(action.data) == false
          return false
      else
        return false
      MessagesStore.emitChange action.data.target_type + action.data.target_id.toString()
      break
  true

module.exports = MessagesStore