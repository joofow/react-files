AppDispatcher = require('../dispatcher/appdispatcher.js.coffee')
EventEmitter = require('events').EventEmitter
appConstants = require('../constants/appConstants.js.coffee')
assign = require('object-assign')

CHANGE_EVENT = 'change'

_participants = []

create: (conversation_id, person_id) ->
  id = Date.now()
  _participants[id] = 
    conversation_id: conversation_id,
    person_id: person_id,
    id: id
    
destroy: (id) ->
  delete _participants[id]

ParticipantsStore = assign {}, EventEmitter.prototype,
  getAll: ->
    _participants
  emitChange: ->
    @emit(CHANGE_EVENT)
  addChangeListener: (callback) ->
    @on CHANGE_EVENT, callback
  removeChangeListener: (callback) ->
    @removeListener CHANGE_EVENT, callback
  dispatcherIndex: AppDispatcher.register (payload) ->
    action = payload.action
    switch action.actionType
      when appConstants.CREATE_PARTICIPANT
        text = action.text.trim()
        console.log('create_participant')
      when appConstants.LOAD_PARTICIPANTS
        text = action.text.trim()
        console.log('load_participant')      
      when appConstants.RECEIVE_PARTICIPANT
        text = action.text.trim()
        console.log('receive_participant')
    true

module.exports = ParticipantsStore