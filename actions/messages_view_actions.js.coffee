appDispatcher = require('../dispatcher/appdispatcher.js.coffee')
appConstants = require('../constants/appConstants.js.coffee')
WebAPIUtils = require('../utils/webAPIutils.js.coffee')

ActionTypes = appConstants.ActionTypes

module.exports =

  postMessage: (id, message) ->
    data =
      id: id
      message: message
    appDispatcher.handleViewAction
      type: ActionTypes.CREATE_MESSAGE
      message: message
      conversation_id: id
  postNewMessage: (message,id) ->
    appDispatcher.handleViewAction
      type: ActionTypes.CREATE_MESSAGE
      id: id
      message: message
    WebAPIUtils.postNewMessage message, id

  getMessages: (target_type,id) ->
    appDispatcher.handleViewAction
      type: ActionTypes.GET_MESSAGES
      target_type: target_type
      target_id: id

  getAllMessages: ->
    appDispatcher.handleViewAction
      type: ActionTypes.GET_ALL_MESSAGES
    WebAPIUtils.getMessages()

  createMessage: (text, target_type, target_id) ->
    appDispatcher.handleViewAction
      type: ActionTypes.CREATE_MESSAGE
      target_type: target_type
      target_id: target_id
      text: text
    WebAPIUtils.createMessage text, target_type, target_id