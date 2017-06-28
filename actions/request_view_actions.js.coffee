appDispatcher = require('../dispatcher/appdispatcher.js.coffee')
appConstants = require('../constants/appConstants.js.coffee')
WebAPIUtils = require('../utils/webAPIutils.js.coffee')

ActionTypes = appConstants.ActionTypes

module.exports =

  createRequest: (data) ->
    appDispatcher.handleViewAction
      type: ActionTypes.CREATE_REQUEST
    WebAPIUtils.createRequest data

  getRequests: ->
    appDispatcher.handleViewAction
      type: ActionTypes.GET_REQUESTS
    WebAPIUtils.getRequests()