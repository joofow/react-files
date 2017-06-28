AppDispatcher = require('../dispatcher/appdispatcher.js.coffee')
EventEmitter = require('events').EventEmitter
appConstants = require('../constants/appConstants.js.coffee')
assign = require('object-assign')

actions = appConstants.ActionTypes

CHANGE_EVENT = 'change'

_tasks = {}
_sorted_list = []

TasksStore = assign {}, EventEmitter.prototype,
 
 getTasks: ->
  _tasks
 getLast: ->
  _tasks[_tasks.length-1]
 getTask: (i) ->
  _tasks[i]
 emitChange: ->
  @emit(CHANGE_EVENT)
 addChangeListener: (callback) ->
  @on CHANGE_EVENT, callback
 removeChangeListener: (callback) ->
  @removeListener CHANGE_EVENT, callback
 addToFeed: (tobeadded) ->
  _tasks[Date.parse(tobeadded.updated_at || tobeadded.created_at)] = tobeadded
 order_list: ->
  nodes = for item of _tasks
    item
  nodes.sort (a,b) ->
    b-a
  _sorted_list = nodes

TasksStore.dispatchToken = AppDispatcher.register (payload) ->
 action = payload.action
 switch action.type
  when actions.RECEIVED_NEW_TASK
   TasksStore.emitChange()
   break
  when actions.RECEIVED_TASKS
   console.log(action.data)
   TasksStore.addToFeed task for task in action.data
   TasksStore.order_list()
   TasksStore.emitChange()
   break
  when actions.RECEIVED_TASK
   TasksStore.addToFeed action.data
   TasksStore.emitChange()
   break
  when actions.DESTROYED_TASK
   TasksStore.emitChange()
   break
  when actions.ASSIGN_NEW_TASK
   TasksStore.emitChange()
   break
 true

module.exports = TasksStore