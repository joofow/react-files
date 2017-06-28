appDispatcher = require('../dispatcher/appdispatcher.js.coffee')
appConstants = require('../constants/appConstants.js.coffee')

ActionTypes = appConstants.ActionTypes

module.exports =

	receivedTask: (task) ->
		appDispatcher.handleServerAction
			type: ActionTypes.RECEIVED_TASK
			data: task
			
	receivedTasks: (data, status, object) ->
		appDispatcher.handleServerAction
			type: ActionTypes.RECEIVED_TASKS
			data: data

	recieveCreatedTask: (data, status, object) ->
		appDispatcher.handleServerAction
			type: ActionTypes.RECEIVED_CREATED_TASK
			data: if status == 'success' then data else null
			errors: if status == 'success' then null else data.errors
			
	updateTask: (data) ->
		appDispatcher.handleServerAction
			type: ActionTypes.UPDATED_TASK
			data: data		