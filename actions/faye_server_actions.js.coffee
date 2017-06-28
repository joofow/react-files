AppDispatcher = require('../dispatcher/appdispatcher.js.coffee')
AppConstants = require('../constants/appConstants.js.coffee')

ActionTypes = AppConstants.ActionTypes

module.exports =

	updateConversation: (data, status, object) ->
		AppDispatcher.handleServerAction
			type: ActionTypes.RECEIVED_CONVERSATION
			data: data
			errors: if status == 'success' then null else data.errors

	updateMessage: (data, status, object) ->
		AppDispatcher.handleServerAction
			type: ActionTypes.RECEIVED_MESSAGE
			data: data
			errors: if status == 'success' then null else data.errors
	updateTask: (data, status, object) ->
		AppDispatcher.handleServerAction
			type: ActionTypes.RECEIVED_TASK
			data: data
			errors: if status == 'success' then null else data.errors
	updateReminder: (data, status, object) ->
		AppDispatcher.handleServerAction
			type: ActionTypes.RECEIVED_REMINDER
			data: data
			errors: if status == 'success' then null else data.errors
	updatePayment: (data, status, object) ->
		AppDispatcher.handleServerAction
			type: ActionTypes.RECEIVED_PAYMENT
			data: data
			errors: if status == 'success' then null else data.errors
