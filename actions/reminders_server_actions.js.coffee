appDispatcher = require('../dispatcher/appdispatcher.js.coffee')
appConstants = require('../constants/appConstants.js.coffee')

ActionTypes = appConstants.ActionTypes

module.exports =

	receivedReminder: (reminder) ->
		appDispatcher.handleServerAction
			type: ActionTypes.RECEIVED_REMINDER
			data: reminder
			
	receivedReminders: (data, status, object) ->
		appDispatcher.handleServerAction
			type: ActionTypes.RECEIVED_REMINDERS
			data: data

	recieveCreatedReminder: (data, status, object) ->
		appDispatcher.handleServerAction
			type: ActionTypes.RECEIVED_CREATED_REMINDER
			data: if status == 'success' then data else null
			errors: if status == 'success' then null else data.errors