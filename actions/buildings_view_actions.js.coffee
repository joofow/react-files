AppDispatcher = require('../dispatcher/appdispatcher.js.coffee')
AppConstants = require('../constants/appConstants.js.coffee')
WebAPIUtils = require('../utils/webAPIutils.js.coffee')

ActionTypes = AppConstants.ActionTypes

module.exports =
 getBuildings: ->
  AppDispatcher.handleViewAction
   type: ActionTypes.GET_BULDINGS
  WebAPIUtils.getBuildings()
  
 createNewBuilding: (data) ->
  AppDispatcher.handleViewAction
   type: ActionTypes.CREATE_BULDING
  WebAPIUtils.createBuilding data

 getDirectory: (id='') ->
  AppDispatcher.handleViewAction
   type: ActionTypes.GET_DIRECTORY
   id: id
  WebAPIUtils.getDirectory id

 getBuildingFeed: (id='') ->
  AppDispatcher.handleViewAction
   type: ActionTypes.GET_BUILDING_FEED
   id: id
  WebAPIUtils.getBuildingFeed id
 
 getInitialBuildingFeed: (id='') ->
  AppDispatcher.handleViewAction
   type: ActionTypes.GET_INITIAL_BUILDING_FEED
   id: id
  WebAPIUtils.getInitialBuildingFeed id

 getPayments: ->
  WebAPIUtils.getPayments()
 
 getPosts: ->
  WebAPIUtils.getPosts()

 getProjects: ->
  WebAPIUtils.getProjects()

 getBuilding: (id='') ->
  AppDispatcher.handleViewAction
   type: ActionTypes.GET_BUILDING
   id: id

 changePage: (page) ->
  AppDispatcher.handleViewAction
   type: ActionTypes.OPEN_PAGE
   page: page
 getApartments: ->
  AppDispatcher.handleViewAction
   type: ActionTypes.GET_APARTMENTS
  WebAPIUtils.getApartments()