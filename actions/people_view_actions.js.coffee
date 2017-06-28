AppDispatcher = require('../dispatcher/appdispatcher.js.coffee')
AppConstants = require('../constants/appConstants.js.coffee')
WebAPIUtils = require('../utils/webAPIutils.js.coffee')

ActionTypes = AppConstants.ActionTypes

module.exports =
 getPeople: ->
  WebAPIUtils.getPeople()
  AppDispatcher.handleViewAction
   type: ActionTypes.GET_PEOPLE

 getPersonInfo: (person_id) ->
  AppDispatcher.handleViewAction
   type: ActionTypes.GET_PERSON_INFO
   person_id: person_id
  WebAPIUtils.getPeople person_id

 startNewConversation: (id) ->
  AppDispatcher.handleViewAction
   type: ActionTypes.START_NEW_CONVERSATION
   id: id

 sendNewReminder: (id) ->
  AppDispatcher.handleViewAction
   type: ActionTypes.SEND_NEW_REMINDER
   id: id

 assignNewTask: (id) ->
  AppDispatcher.handleViewAction
   type: ActionTypes.ASSIGN_NEW_TASK
   id: id

 makeNewPayment: (id) ->
  AppDispatcher.handleViewAction
   type: ActionTypes.MAKE_NEW_PAYMENT
   id: id

 openActions: (id) ->
  AppDispatcher.handleViewAction
   type: ActionTypes.OPEN_ACTIONS
   id: id