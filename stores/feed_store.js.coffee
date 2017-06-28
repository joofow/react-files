AppDispatcher = require('../dispatcher/appdispatcher.js.coffee')
EventEmitter = require('events').EventEmitter
appConstants = require('../constants/appConstants.js.coffee')
assign = require('object-assign')
ConversationsStore = require('./conversation_stores.js.coffee')
RemindersStore = require('./reminders_store.js.coffee')
TasksStore = require('./tasks_store.js.coffee')
PaymentsStore = require('./payments_store.js.coffee')
UnreadConversationsStore = require('./unread_conversations_stores.js.coffee')
PeopleStore = require('./people_store.js.coffee')

EventEmitter.prototype.request = ->
  self = this
  self.setMaxListeners(0)

actions = appConstants.ActionTypes

CHANGE_EVENT = 'change'
NEW_ACTION_EVENT = 'new_action'

_feed = {}
_unread = {}
_unread_hash_list = {}
_feed_hash_list = {}
_unread_order_list = []
_order_list = []
_errors = []
_people = {}
_action = { visible: false }
_filter = ''
    
onlyUnique: (value, index, self) ->
  self.indexOf(value) == index

FeedStore = assign {}, EventEmitter.prototype,

  destroy: (id) ->
    delete _feed[id]

  action_reset: ->
    _action = { visible: false }
  new_actions: (id, type, apartment = false) ->
    if apartment
      _people.each (person) ->
        $.extend(_action, {assigned_person_id: person.id, type: type })
    else
      $.extend(_action, {assigned_person_id: id, type: type })
      _action['visible'] = true
  getKeys: ->
    _feed_hash_list = {}
    for item of _feed
      _feed_hash_list[Date.parse(_feed[item].updated_at)] = item
    nodes = for item of _feed_hash_list
      item
    nodes.sort (a,b) ->
      b-a
    nodes
  setFilter: (type) ->
    _filter = type
  filterFeed: (feed) ->
    ret = []
    ret.push(ids) for ids in feed when ids.type_type == _filter
    ret 
  getUnreadKeys: ->
    _unread_hash_list = {}
    for item of _unread
      _unread_hash_list[Date.parse(_unread[item].updated_at)] = item
    nodes = for item of _unread_hash_list
      item
    nodes.sort (a,b) ->
      b-a
    nodes
  getConversations: ->
    _unread = $.extend({},_unread,UnreadConversationsStore.getUnreadConversations())
    _feed = $.extend({},_feed,ConversationsStore.getConversations())
  getNew: ->
    _action
  getFeed: ->
    unread = FeedStore.getUnread()
    feed = FeedStore.getKeys().map (key) ->
      unless _feed_hash_list[_unread_hash_list[key]]
        jQuery.extend(_feed[_feed_hash_list[key]],{key: _feed[_feed_hash_list[key]].id_time})
    tool = unread.concat(feed)
    if _filter? && _filter.length > 0
      tool = FeedStore.filterFeed tool
    tool
  getUnread: ->
    feed = FeedStore.getUnreadKeys().map (key) ->
      jQuery.extend(_unread[_unread_hash_list[key]],{key: _unread[_unread_hash_list[key]].id_time})
    feed
  getPeople: ->
    _people
  getMessage: (id) ->
    _feed[id]
  getErrors: ->
    _errors
  emitChange: (eventname = CHANGE_EVENT) ->
    @emit(eventname)
  addChangeListener: (callback,eventname = CHANGE_EVENT) ->
    @on eventname, callback
  removeChangeListener: (callback,eventname = CHANGE_EVENT) ->
    @removeListener eventname, callback
  addToFeed: (tobeadded, type) ->
    _feed[Date.parse(tobeadded.updated_at || tobeadded.created_at)] = $.extend(tobeadded,{type: type})
  
FeedStore.dispatchToken = AppDispatcher.register (payload) ->
  action = payload.action
  switch action.type
    when actions.OPEN_ACTIONS
      FeedStore.new_actions action.id, 'actions', actions.apartment
      FeedStore.emitChange(NEW_ACTION_EVENT)
    when actions.RECEIVED_CONVERSATIONS
      AppDispatcher.waitFor([UnreadConversationsStore.dispatchToken])
      AppDispatcher.waitFor([ConversationsStore.dispatchToken])
      AppDispatcher.waitFor([PeopleStore.dispatchToken])
      FeedStore.getConversations()
      FeedStore.emitChange()
      break    
    when actions.RECEIVED_CONVERSATION
      AppDispatcher.waitFor([UnreadConversationsStore.dispatchToken])
      FeedStore.getConversations()
      FeedStore.emitChange()
      break
    when actions.RECEIVED_TASK
      AppDispatcher.waitFor([TasksStore.dispatchToken])
      AppDispatcher.waitFor([UnreadConversationsStore.dispatchToken])
      FeedStore.getConversations()
      FeedStore.emitChange()
      break
    when actions.RECEIVED_REMINDER
      AppDispatcher.waitFor([RemindersStore.dispatchToken])
      AppDispatcher.waitFor([UnreadConversationsStore.dispatchToken])
      FeedStore.getConversations()
      FeedStore.emitChange()
      break
    when actions.RECEIVED_PAYMENT
      AppDispatcher.waitFor([PaymentsStore.dispatchToken])
      AppDispatcher.waitFor([UnreadConversationsStore.dispatchToken])
      FeedStore.getConversations()
      FeedStore.emitChange()
      break
    when actions.CREATE_REMINDER
      FeedStore.action_reset()
      FeedStore.emitChange(NEW_ACTION_EVENT)
    when actions.RECEIVED_PEOPLE
      if action.errors
        _error.push action.errors
      if action.data
        action.data.map (person) ->
          _people[person.id] = person
      FeedStore.emitChange()
      break
    when actions.ADDED_PERSON
      if action.errors
        _error.push action.errors
      if action.data
        _people[action.data.id] = action.data
        _error = []
      FeedStore.emitChange()
      break
    when actions.FILTER_FEED
      FeedStore.setFilter action.data
      FeedStore.emitChange()
    when actions.CREATE_TASK
      FeedStore.action_reset()
      FeedStore.emitChange(NEW_ACTION_EVENT)
    when actions.CREATE_MESSAGE
      FeedStore.action_reset()
      FeedStore.emitChange(NEW_ACTION_EVENT)
    when actions.CREATE_PAYMENT
      FeedStore.action_reset()
      FeedStore.emitChange(NEW_ACTION_EVENT)
    when actions.START_NEW_CONVERSATION
      FeedStore.new_actions action.id, 'message'
      FeedStore.emitChange(NEW_ACTION_EVENT)
    when actions.MAKE_NEW_PAYMENT
      FeedStore.new_actions action.id, 'payment'
      FeedStore.emitChange(NEW_ACTION_EVENT)
    when actions.ASSIGN_NEW_TASK
      FeedStore.new_actions action.id, 'task'
      FeedStore.emitChange(NEW_ACTION_EVENT)
    when actions.SEND_NEW_REMINDER
      FeedStore.new_actions action.id, 'reminder'
      FeedStore.emitChange(NEW_ACTION_EVENT)

module.exports = FeedStore