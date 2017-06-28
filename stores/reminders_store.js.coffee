AppDispatcher = require('../dispatcher/appdispatcher.js.coffee')
EventEmitter = require('events').EventEmitter
appConstants = require('../constants/appConstants.js.coffee')
assign = require('object-assign')

actions = appConstants.ActionTypes

CHANGE_EVENT = 'reminder_change'

_reminders = {}
_sorted_list = []

RemindersStore = assign {}, EventEmitter.prototype,
 
 getLast: ->
  _reminders[_reminders.length-1]
 getReminders: ->
  _reminders
 getReminder: (i) ->
  _reminders[i]
 emitChange: ->
  @emit(CHANGE_EVENT)
 addChangeListener: (callback) ->
  @on CHANGE_EVENT, callback
 removeChangeListener: (callback) ->
  @removeListener CHANGE_EVENT, callback
 removeUnwanted: ->
  for reminder,i in _reminders
   _reminders.splice(i,1) unless reminder.person_id
 addToFeed: (tobeadded, type) ->
  _reminders[Date.parse(tobeadded.updated_at)] = tobeadded
 order_list: ->
  nodes = for item of _reminders
    item
  nodes.sort (a,b) ->
    b-a
  _sorted_list = nodes

RemindersStore.dispatchToken = AppDispatcher.register (payload) ->
 action = payload.action
 switch action.type
  when actions.CREATE_REMINDER
   RemindersStore.emitChange()
  when actions.SEND_NEW_REMINDER
   RemindersStore.emitChange()
   break
  when actions.RECEIVED_REMINDER
   RemindersStore.addToFeed reminder,'reminder' for reminder in action.data
   RemindersStore.order_list()
   RemindersStore.emitChange()
   break
  when actions.RECEIVED_NEW_REMINDER
   RemindersStore.emitChange()
   break
  when actions.RECEIVED_REMINDERS
   RemindersStore.addToFeed reminder,'reminder' for reminder in action.data
   RemindersStore.order_list()
   RemindersStore.emitChange()
   break
  when actions.DESTROYED_REMINDER
   RemindersStore.emitChange()
   break
 true

module.exports = RemindersStore