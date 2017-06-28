AppDispatcher = require('../dispatcher/appdispatcher.js.coffee')
EventEmitter = require('events').EventEmitter
appConstants = require('../constants/appConstants.js.coffee')
messagesActionCreators = require('../actions/messages_server_actions.js.coffee')

assign = require('object-assign')

actions = appConstants.ActionTypes

CHANGE_EVENT = 'change'

_conversations = {}
_order_list = {}
_sorted_list = []
_conversation = {title: "", person_id: "", messages: ""}

ConversationsStore = assign {}, EventEmitter.prototype,
  
  destroy: (id) ->
    delete _conversations[id]
  getLast: ->
    _conversations[_conversations.length-1]
  getConversations: ->
    _conversations
  getConversation: ->
    _conversation
  getErrors: ->
    _errors
  emitChange: ->
    @emit(CHANGE_EVENT)
  addChangeListener: (callback) ->
    @on CHANGE_EVENT, callback
  removeChangeListener: (callback) ->
    @removeListener CHANGE_EVENT, callback
  addToFeed: (tobeadded, type) ->
    ConversationsStore.destroy Date.parse(tobeadded.created_at)
    unless tobeadded.updated_conversation || tobeadded.new_conversation
      _conversations[Date.parse(tobeadded.created_at)] = tobeadded
  order_list: ->
    nodes = for item of _conversations
      _order_list[_conversations[item].updated_at] = item
      item
    nodes.sort (a,b) ->
      b-a
    _sorted_list = nodes

ConversationsStore.dispatchToken = AppDispatcher.register (payload) ->
    action = payload.action
    switch action.type
      when actions.RECEIVED_CONVERSATION
        ConversationsStore.addToFeed action.data,'conversation'
        ConversationsStore.emitChange()
        break
      when actions.RECEIVED_CONVERSATIONS
        ConversationsStore.addToFeed conversation,'conversation' for conversation in action.data
        ConversationsStore.order_list()
        ConversationsStore.emitChange()
        break
      when actions.ADDED_TO_CONVERSATION
        if action.data
          _conversations = create action.data
          _errors = []
        if action.errors
          _errors = action.errors
        ConversationsStore.emitChange()
        break
      when actions.START_NEW_CONVERSATION
        ConversationsStore.emitChange()
        break
    true

module.exports = ConversationsStore
