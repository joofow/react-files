AppDispatcher = require('../dispatcher/appdispatcher.js.coffee')
AppConstants = require('../constants/appConstants.js.coffee')
WebAPIUtils = require('../utils/webAPIutils.js.coffee')

ActionTypes = AppConstants.ActionTypes

module.exports = 
  getAllConversations: ->
    AppDispatcher.handleViewAction
      type: ActionTypes.GET_ALL_CONVERSATIONS
    WebAPIUtils.getConversations()
  clickConversation: ( conversationId ) ->
    AppDispatcher.handleViewAction
      type: ActionTypes.CLICK_CONVERSATION
      conversation_id: conversationId
  updateConversation: (data) ->
    AppDispatcher.handleViewAction
      type: ActionTypes.UPDATE_CONVERSATION
      data: data
    WebAPIUtils.postMessage data    
  createConversation: ( data ) ->
    AppDispatcher.handleViewAction
      type: ActionTypes.CREATE_CONVERSATION
      data: data
    WebAPIUtils.createConversation data
  addPeopleToConversation: (conversation_id, person_id) ->
   	AppDispatcher.handleViewAction
   		type: ActionTypes.ADD_PEOPLE_CONVERSATION
   		person_id: person_id
   		conversation_id: conversation_id
   	WebAPIUtils.addPeopleToConversation conversation_id, person_id