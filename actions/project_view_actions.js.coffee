appDispatcher = require('../dispatcher/appdispatcher.js.coffee')
appConstants = require('../constants/appConstants.js.coffee')
WebAPIUtils = require('../utils/webAPIutils.js.coffee')

ActionTypes = appConstants.ActionTypes

module.exports =

	receivedProjects: (projects, status, object) ->
		appDispatcher.handleViewActions
			type: ActionTypes.RECEIVED_PROJECTS
			data: projects

	chosenAudienceType: (type) ->
		appDispatcher.handleViewAction
			type: ActionTypes.CHOSEN_PROJECT_AUDIENCE_TYPE
			data: type
	
	chosenAudienceId: (id) ->
		appDispatcher.handleViewAction
			type: ActionTypes.CHOSEN_PROJECT_AUDIENCE_ID
			data: id
		WebAPIUtils.getDirectory id
	
	changeAudienceId: (id) ->
		appDispatcher.handleViewAction
			type: ActionTypes.CHANGE_PROJECT_AUDIENCE_ID
			data: id
	
	updateDates: (data) ->
		appDispatcher.handleViewAction
			type: ActionTypes.UPDATE_PROJECT_DATES
			data: data
	
	updateAcknowledgement: (data) ->
		appDispatcher.handleViewAction
			type: ActionTypes.UPDATE_PROJECT_ACKNOWLEDGEMENT
			data: data
	
	updateMessage: (data) ->
		appDispatcher.handleViewAction
			type: ActionTypes.UPDATE_PROJECT_MESSAGE
			data: data

	createNewProject: (data) ->
		appDispatcher.handleViewAction
			type: ActionTypes.CREATED_NEW_PROJECT
			data: data
		WebAPIUtils.createProject {project: data}

	clearNewProject: ->
		appDispatcher.handleViewAction
			type: ActionTypes.CLEAR_NEW_PROJECT

	submitMessage: (data) ->
		appDispatcher.handleViewAction
			type: ActionTypes.UPDATE_PROJECT_MESSAGE
			data: data
	updateProject: (id,hash) ->
		appDispatcher.handleViewAction
			type: ActionTypes.UPDATE_PROJECT
			data: hash
			id: id
		WebAPIUtils.updateProject id, hash