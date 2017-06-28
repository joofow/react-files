appDispatcher = require('../dispatcher/appdispatcher.js.coffee')
appConstants = require('../constants/appConstants.js.coffee')
WebAPIUtils = require('../utils/webAPIutils.js.coffee')

ActionTypes = appConstants.ActionTypes

module.exports =

	chosenAudienceType: (type) ->
		appDispatcher.handleViewAction
			type: ActionTypes.CHOSEN_AUDIENCE_TYPE
			data: type
	
	chosenAudienceId: (id) ->
		appDispatcher.handleViewAction
			type: ActionTypes.CHOSEN_AUDIENCE_ID
			data: id
		WebAPIUtils.getDirectory id
	
	changeAudienceId: (id) ->
		appDispatcher.handleViewAction
			type: ActionTypes.CHANGE_AUDIENCE_ID
			data: id
	
	updateDates: (data) ->
		appDispatcher.handleViewAction
			type: ActionTypes.UPDATE_POST_DATES
			data: data
	
	confirmFinal: (data) ->
		appDispatcher.handleViewAction
			type: ActionTypes.UPDATE_ACKNOWLEDGEMENT
			data: data
	
	updateMessage: (data) ->
		appDispatcher.handleViewAction
			type: ActionTypes.UPDATE_POST_MESSAGE
			data: data

	createNewPost: (data) ->
		appDispatcher.handleViewAction
			type: ActionTypes.CREATED_NEW_POST
			data: data
		WebAPIUtils.createPost data

	clearNewPost: ->
		appDispatcher.handleViewAction
			type: ActionTypes.CLEAR_NEW_POST

	submitMessage: (data) ->
		appDispatcher.handleViewAction
			type: ActionTypes.UPDATE_POST_MESSAGE
			data: data
	editPost: (id) ->
		appDispatcher.handleViewAction
			type: ActionTypes.EDIT_POST
			data: id
	changeStatus: (action, id) ->
		appDispatcher.handleViewAction
			type: ActionTypes.CHANGE_POST_STATUS
			data: {id: id, archive: action }
		WebAPIUtils.changePostStatus id, action

	updatePost: (id,hash) ->
		appDispatcher.handleViewAction
			type: ActionTypes.UPDATE_POST
			data: hash
			id: id
		WebAPIUtils.updatePost id, hash