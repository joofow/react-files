AppDispatcher = require('../dispatcher/appdispatcher.js.coffee')
AppConstants = require('../constants/appConstants.js.coffee')

ActionTypes = AppConstants.ActionTypes

module.exports =
	receivedBuildings: (data, status, object ) ->
		AppDispatcher.handleServerAction
			type: ActionTypes.RECEIVED_BUILDINGS
			data: data

	addedBuilding: (data, status, object ) ->
		AppDispatcher.handleServerAction
			type: ActionTypes.ADDED_BUILDING
			data: data
			errors: if status == 'success' then null else data.errors

	receivedDirectory: (data, status, object ) ->
		AppDispatcher.handleServerAction
			type: ActionTypes.RECEIVED_DIRECTORY
			data: data
			
	receivedFeed: (data, status, object) ->
		AppDispatcher.handleServerAction
			type: ActionTypes.RECEIVED_BUILDING_FEED
			data: data
	
	receivedInitialFeed: (data, status, object) ->
		AppDispatcher.handleServerAction
			type: ActionTypes.RECEIVED_INITIAL_BUILDING_FEED
			data: data

	receivedBuilding: (data, status, object) ->
		AppDispatcher.handleServerAction
			type: ActionTypes.RECEIVED_BUILDING
			data: data