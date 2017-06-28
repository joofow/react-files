AppDispatcher = require('../dispatcher/appdispatcher.js.coffee')
AppConstants = require('../constants/appConstants.js.coffee')

ActionTypes = AppConstants.ActionTypes

module.exports =
	receivedPeople: (data, status, object ) ->
		AppDispatcher.handleServerAction
			type: ActionTypes.RECEIVED_PEOPLE
			data: data

	addedPerson: (data, status, object ) ->
		AppDispatcher.handleServerAction
			type: ActionTypes.ADDED_PERSON
			data: data
			errors: if status == 'success' then null else data.errors