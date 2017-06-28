appDispatcher = require('../dispatcher/appdispatcher.js.coffee')
appConstants = require('../constants/appConstants.js.coffee')

ActionTypes = appConstants.ActionTypes

module.exports =

	receivedRequest: (reminder) ->
		appDispatcher.handleServerAction
			type: ActionTypes.RECEIVED_REQUEST
			data: reminder
			
	receivedRequests: (data, status, object) ->
		appDispatcher.handleServerAction
			type: ActionTypes.RECEIVED_REQUESTS
			data: data