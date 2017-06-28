appDispatcher = require('../dispatcher/appdispatcher.js.coffee')
appConstants = require('../constants/appConstants.js.coffee')

ActionTypes = appConstants.ActionTypes

module.exports =

	receivedMessage: (message) ->
		appDispatcher.handleServerAction
			type: ActionTypes.RECEIVED_MESSAGE
			data: message
	
	createdMessage: (data, status, object) ->
		appDispatcher.handleServerAction
			type: ActionTypes.RECEIVED_MESSAGE
			data: data

	receivedMessages: (data, status, object) ->
		appDispatcher.handleServerAction
			type: ActionTypes.RECEIVED_MESSAGES
			data: if status == 'success' then data else null
			errors: if status == 'success' then null else data.errors

	recieveCreatedMessage: (data, status, object) ->
		appDispatcher.handleServerAction
			type: ActionTypes.RECEIVED_CREATED_MESSAGE
			data: if status == 'success' then data else null
			errors: if status == 'success' then null else data.errors
