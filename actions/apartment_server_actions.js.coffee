AppDispatcher = require('../dispatcher/appdispatcher.js.coffee')
AppConstants = require('../constants/appConstants.js.coffee')

ActionTypes = AppConstants.ActionTypes

module.exports =
	receivedApartments: (data, status, object ) ->
		AppDispatcher.handleServerAction
			type: ActionTypes.RECEIVED_APARTMENTS
			data: data

	addedApertment: (data, status, object ) ->
		AppDispatcher.handleServerAction
			type: ActionTypes.ADDED_APARTMENT
			data: data
			errors: if status == 'success' then null else data.errors
	receivedDirectory: (data, status, object) ->
		AppDispatcher.handleServerAction
			type: ActionTypes.RECEIVED_DIRECTORY
			data: data