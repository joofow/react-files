appDispatcher = require('../dispatcher/appdispatcher.js.coffee')
appConstants = require('../constants/appConstants.js.coffee')
WebAPIUtils = require('../utils/webAPIutils.js.coffee')

ActionTypes = appConstants.ActionTypes

module.exports =

  createReminder: (assigned_person_id, text, date) ->
    data =
      assigned_person_id: assigned_person_id
      text: text
      end_date: date
    appDispatcher.handleViewAction
      type: ActionTypes.CREATE_REMINDER
    WebAPIUtils.createReminder data

  getReminders: ->
    appDispatcher.handleViewAction
      type: ActionTypes.GET_REMINDERS
    WebAPIUtils.getReminders()