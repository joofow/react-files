AppDispatcher = require('../dispatcher/appdispatcher.js.coffee')
AppConstants = require('../constants/appConstants.js.coffee')

ActionTypes = AppConstants.ActionTypes

module.exports =

	receivedConversations: (data, status, object) ->
		AppDispatcher.handleServerAction
			type: ActionTypes.RECEIVED_CONVERSATIONS
			data: data
			errors: if status == 'success' then null else data.errors

	receivedCreatedConversation: (data, status, object) ->
		AppDispatcher.handleServerAction
			type: ActionTypes.RECEIVED_CONVERSATION 
			data: data

	addedToConversation: (data, status, object) ->
		AppDispatcher.handleServerAction
			type: ActionTypes.ADDED_TO_CONVERSATION
			data: if status == 'success' then data else null
			errors: if status == 'success' then null else data.errors