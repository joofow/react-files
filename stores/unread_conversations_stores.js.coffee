AppDispatcher = require('../dispatcher/appdispatcher.js.coffee')
EventEmitter = require('events').EventEmitter
appConstants = require('../constants/appConstants.js.coffee')
messagesActionCreators = require('../actions/messages_server_actions.js.coffee')
ConversationStore = require('./conversation_stores.js.coffee')

assign = require('object-assign')

actions = appConstants.ActionTypes

CHANGE_EVENT = 'change'

_conversations = {}
_sorted_list = []
_conversation = {title: "", person_id: "", messages: ""}

UnreadConversationsStore = assign {}, EventEmitter.prototype,
  
  destroy: (id) ->
    delete _conversations[id]
  getLast: ->
    _conversations[_conversations.length-1]
  getUnreadConversations: ->
    console.log(_conversations)
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
    if tobeadded.new_conversation 
      UnreadConversationsStore.destroy Date.parse(tobeadded.created_at)
      _conversations[Date.parse(tobeadded.created_at)] = tobeadded
  order_list: ->
    nodes = for item of _conversations
      item
    nodes.sort (a,b) ->
      b-a
    _sorted_list = nodes

UnreadConversationsStore.dispatchToken = AppDispatcher.register (payload) ->
    action = payload.action
    switch action.type
      when actions.RECEIVED_CONVERSATION
        UnreadConversationsStore.addToFeed action.data,'conversation'
        UnreadConversationsStore.emitChange()
        break
      when actions.RECEIVED_TASK
        UnreadConversationsStore.addToFeed action.data,'task'
        UnreadConversationsStore.emitChange()
        break
      when actions.RECEIVED_REMINDER
        UnreadConversationsStore.addToFeed action.data,'reminder'
        UnreadConversationsStore.emitChange()
        break
      when actions.RECEIVED_PAYMENT
        UnreadConversationsStore.addToFeed action.data,'payment'
        UnreadConversationsStore.emitChange()
        break        
      when actions.RECEIVED_CONVERSATIONS
        UnreadConversationsStore.addToFeed conversation,'conversation' for conversation in action.data
        UnreadConversationsStore.order_list()
        UnreadConversationsStore.emitChange()
        break
      when actions.ADDED_TO_CONVERSATION
        if action.data
          _conversations = create action.data
          _errors = []
        if action.errors
          _errors = action.errors
        UnreadConversationsStore.emitChange()
        break
      when actions.START_NEW_CONVERSATION
        UnreadConversationsStore.emitChange()
        break
    true

module.exports = UnreadConversationsStore
