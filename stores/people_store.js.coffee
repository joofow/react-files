AppDispatcher = require('../dispatcher/appdispatcher.js.coffee')
EventEmitter = require('events').EventEmitter
AppConstants = require('../constants/appConstants.js.coffee')
assign = require('object-assign')

CHANGE_EVENT = 'change'

actions = AppConstants.ActionTypes

_persons = {}

create: (person_id) ->
 _persons[person_id] = 
  id: id
        
destroy: (id) ->
 delete _persons[id]

PeopleStore = assign {}, EventEmitter.prototype,
 getAll: ->
  _persons
 getAllArray: ->
  peopleArray = []
  peopleArray.push(_persons[person]) for person of _persons
  peopleArray
 
 getMe: ->
  me = PeopleStore.getAllArray().filter (p) ->
   p.me
  me[0] 
 emitChange: ->
  @emit(CHANGE_EVENT)
 addChangeListener: (callback) ->
  @on CHANGE_EVENT, callback
 removeChangeListener: (callback) ->
  @removeListener CHANGE_EVENT, callback

PeopleStore.dispatchToken = AppDispatcher.register (payload) ->
 action = payload.action
 switch action.type
  when actions.RECEIVED_PEOPLE
   if action.errors
    _error.push action.errors
   if action.data
    action.data.map (person) ->
     _persons[person.id] = person
   break
  when actions.ADDED_PERSON
   if action.errors
    _error.push action.errors
   if action.data
    _persons[action.data.id] = action.data
    _error = []
   PeopleStore.emitChange()
   break
 true

module.exports = PeopleStore