appDispatcher = require('../dispatcher/appdispatcher.js.coffee')
appConstants = require('../constants/appConstants.js.coffee')

ActionTypes = appConstants.ActionTypes

module.exports =

	receivedPosts: (posts, status, object) ->
		appDispatcher.handleServerAction
			type: ActionTypes.RECEIVED_POSTS
			data: posts

	createdNewPost: (post, status, object) ->
		appDispatcher.handleServerAction
			type: ActionTypes.CREATED_POST
			data: post

	receivedPost: (post) ->
		appDispatcher.handleServerAction
			type: ActionTypes.RECEIVED_POST
			data: post

	changedStatus: (data) ->
		appDispatcher.handleServerAction
			type: ActionTypes.CHANGED_POST_STATUS
			data: data
	updatedPost: (data, status) ->
		appDispatcher.handleServerAction
			type: ActionTypes.UPDATED_POST
			data: data