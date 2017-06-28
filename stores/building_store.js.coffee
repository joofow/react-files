AppDispatcher = require('../dispatcher/appdispatcher.js.coffee')
EventEmitter = require('events').EventEmitter
AppConstants = require('../constants/appConstants.js.coffee')
assign = require('object-assign')

CHANGE_EVENT = 'change'

actions = AppConstants.ActionTypes
_buildings = []
_error = []
_directory = []
_active = []
_feed = []
_active_id = ''
_current_page = 'properties'
_initial = false
BuildingStore = assign {}, EventEmitter.prototype,
 
 getActiveBuilding: ->
  _active
 getCurrentBuildingFeed: ->
  current_feed = []
  _feed.map (feed) ->
    if feed.building_id == _active_id
      current_feed.push feed
    else
  current_feed
 getCurrentPage: ->
  _current_page
 getAllBuildings: ->
  _buildings
 getDirectory: ->
  _directory
 getInitialStatus: ->
  _initial
 getBuildingFeed: ->
  _feed
 emitChange: (newevent = CHANGE_EVENT) ->
  @emit(newevent)
 addChangeListener: (change_event, callback) ->
  @on change_event, callback
 removeChangeListener: (change_event, callback) ->
  @removeListener change_event, callback

BuildingStore.dispatchToken = AppDispatcher.register (payload) ->
 action = payload.action
 switch action.type
  when actions.RECEIVED_BUILDINGS
   if action.errors
    _error.push action.errors
   if action.data
    action.data.map (building) ->
     if _active.length == 0
      _active.push building
      _active_id = building.id
     _buildings.push building
   BuildingStore.emitChange()
   break
  when actions.ADDED_BUILDING
   if action.data
     _buildings.push action.data.building
   BuildingStore.emitChange('added')   
   break
  when actions.RECEIVED_DIRECTORY
   if action.errors
     _errors.push action.errors
   if action.data
     _directory = []
     action.data.map (apt) ->
      _directory.push apt
   BuildingStore.emitChange() 
   break
  when actions.RECEIVED_BUILDING_FEED
   if action.errors
     _errors.push action.errors
   if action.data
     action.data.map (apt) ->
      _feed.push apt
   BuildingStore.emitChange() 
   break
  when actions.RECEIVED_INITIAL_BUILDING_FEED
   if action.data
    _feed = []
    action.data.map (apt) ->
     _feed.push apt
   _initial = true
   BuildingStore.emitChange() 
   break
  when actions.OPEN_PAGE
   if action.page
    _current_page = action.page
   BuildingStore.emitChange('new_page') 
   break
  when actions.GET_BUILDING
   _active_id = action.id
   _active = []
   _buildings.map (building) ->
    if building.id == action.id
      _active.push building
   BuildingStore.emitChange() 
   break
  when actions.RECEIVED_BUILDING
   if action.data
    _active = action.data
   BuildingStore.emitChange() 
   break
  else
   break

module.exports = BuildingStore