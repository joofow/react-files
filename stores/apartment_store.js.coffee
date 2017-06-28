AppDispatcher = require('../dispatcher/appdispatcher.js.coffee')
EventEmitter = require('events').EventEmitter
AppConstants = require('../constants/appConstants.js.coffee')
assign = require('object-assign')

CHANGE_EVENT = 'change'

actions = AppConstants.ActionTypes

_apartments = []
        
destroy: (id) ->
 delete _persons[id]

ApartmentStore = assign {}, EventEmitter.prototype,
 getApartments: ->
  _apartments
 emitChange: ->
  @emit(CHANGE_EVENT)
 addChangeListener: (callback) ->
  @on CHANGE_EVENT, callback
 removeChangeListener: (callback) ->
  @removeListener CHANGE_EVENT, callback

ApartmentStore.dispatchToken = AppDispatcher.register (payload) ->
 action = payload.action
 switch action.type
  when actions.RECEIVED_APARTMENTS
   if action.errors
    _error.push action.errors
   if action.data
    action.data.map (apartment) ->
     _apartments.push apartment
   ApartmentStore.emitChange()
   break
  when actions.ADDED_APARTMENT
   if action.errors
    _error.push action.errors
   if action.data
    _apartments.push action.data
    _error = []
   ApartmentStore.emitChange()
   break
  when actions.ADDED_BUILDING
   if action.apartments
    _apartments.push action.apartments 
   ApartmentStore.emitChange()
   break
 true

module.exports = ApartmentStore