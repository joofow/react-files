appDispatcher = require('../dispatcher/appdispatcher.js.coffee')
appConstants = require('../constants/appConstants.js.coffee')

ActionTypes = appConstants.ActionTypes

module.exports =

	receivedProjects: (projects, status, object) ->
		appDispatcher.handleServerAction
			type: ActionTypes.RECEIVED_PROJECTS
			data: projects
	updatedProject: (data,status) ->
		appDispatcher.handleServerAction
			type: ActionTypes.UPDATED_PROJECT
			data: if status == 'success' then data else null
			error: if status != 'success' then data else null
	createdNewProject: (data,status, object) ->
		appDispatcher.handleServerAction
			type: ActionTypes.CREATED_PROJECT
			data: if status == 'success' then data else null
			error: if status != 'success' then data else null