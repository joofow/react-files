AppDispatcher = require('../dispatcher/appdispatcher.js.coffee')
AppConstants = require('../constants/appConstants.js.coffee')
WebAPIUtils = require('../utils/webAPIutils.js.coffee')

ActionTypes = AppConstants.ActionTypes

module.exports =
 getApartments: ->
  WebAPIUtils.getApartments()
  AppDispatcher.handleViewAction
   type: ActionTypes.GET_APARTMENTS
    
 createApartment: (data) ->
  AppDispatcher.handleViewAction
   type: ActionTypes.CREATE_APARTMENT
   person_id: person_id
  WebAPIUtils.createApartment data
 
 openActions: (id) ->
  AppDispatcher.handleViewAction
   type: ActionTypes.OPEN_ACTIONS
   id: id
   apartment: true