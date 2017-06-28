appDispatcher = require('../dispatcher/appdispatcher.js.coffee')
appConstants = require('../constants/appConstants.js.coffee')
WebAPIUtils = require('../utils/webAPIutils.js.coffee')

ActionTypes = appConstants.ActionTypes

module.exports =

  createTask: (data) ->
    appDispatcher.handleViewAction
      type: ActionTypes.CREATE_TASK
    WebAPIUtils.postNewTask data
    
  getMessages: (currentConvId) ->
    appDispatcher.handleViewAction
      type: ActionTypes.GET_TASKS
    WebAPIUtils.getTasks()
  updateTask: (data) ->
  	 WebAPIUtils.updateTask data