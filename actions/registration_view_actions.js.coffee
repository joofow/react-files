appDispatcher = require('../dispatcher/appdispatcher.js.coffee')
appConstants = require('../constants/appConstants.js.coffee')
WebAPIUtils = require('../utils/webAPIutils.js.coffee')

ActionTypes = appConstants.ActionTypes

module.exports =

  createProperty: (data) ->
    appDispatcher.handleViewAction
      type: ActionTypes.CREATE_PROPERTY
    WebAPIUtils.createRequest data

  createApartment: ->
    appDispatcher.handleViewAction
      type: ActionTypes.CREATE_APARTMENT
    WebAPIUtils.getRequests()

  createTenant: ->
    appDispatcher.handleViewAction
      type: ActionTypes.CREATE_TENANT
    WebAPIUtils.getRequests()

  findZip: (zip) ->
    appDispatcher.handleViewAction
      type: ActionTypes.FIND_ZIP
      data: zip

  findBuilding: ->
    appDispatcher.handleViewAction
      type: ActionTypes.FIND_BUILDING
    WebAPIUtils.getRequests()

  updateBuildingSize: (data) ->
    appDispatcher.handleViewAction
      type: ActionTypes.UPDATE_BUILDING_SIZE
      data: data
  
  activate_apartment: (apt) ->
    appDispatcher.handleViewAction
      type: ActionTypes.ACTIVATE_APARTMENT
      data: apt
  
  addNewTenant: (tenant) ->
    appDispatcher.handleViewAction
      type: ActionTypes.ADD_NEW_TENANT
      data: tenant

  save_information: (data) ->
    appDispatcher.handleViewAction
      type: ActionTypes.RECORD_UNIT_INFORMATION
      data: data

  save_information_and_request_confirmation: (property, apartments, tenants, unit) ->
    appDispatcher.handleViewAction
      type: ActionTypes.RECORD_UNIT_INFORMATION
      data: unit
    WebAPIUtils.createNewProperty property, apartments, tenants