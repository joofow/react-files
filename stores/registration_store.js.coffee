AppDispatcher = require('../dispatcher/appdispatcher.js.coffee')
EventEmitter = require('events').EventEmitter
AppConstants = require('../constants/appConstants.js.coffee')
assign = require('object-assign')

CHANGE_EVENT = 'form_change'

actions = AppConstants.ActionTypes

_new_property =
	zipcode: null
	building_name: null
	address_line_1: null
	address_line_2: null
	city: null
	state: null
	units: null
	floors: null

_new_apartment =
	bedrooms: null
	bathrooms: null
	floor_size: null
	occupants: null
	lease_end: null
	rent_mo: null
	rent_due: null
	rent_late: null
	name: null

_new_tenant: 
	first_name: null
	last_name: null
	phone: null
	email: null

_tenants = {}
_apartments = {}
_property = {}
_streets = []
_steps = 1
_active_apartment = ''
_message = {}

RegistrationStore = assign {}, EventEmitter.prototype,
	
	getStep: ->
		_steps
 getSaveMessage: ->
  if Object.keys(_message).length > 0
   _message
  else
   {time: Date.now()-100, message: ''}
	getNewProperty: ->
		_new_property
	getProperty: ->
		_new_property
 getActiveApartmentNo: ->
  _active_apartment
	getActiveApartment: ->
		if _apartments[_active_apartment]? then _apartments[_active_apartment] else _new_apartment
 getCurrentTenants: ->
  if _tenants[_active_apartment]? then _tenants[_active_apartment] else []
	getNewApartment: ->
		_new_apartment
	getNewTenant: ->
		_new_tenant
	getAllTenants: ->
		_tenants
	getAllApartments: ->
		_apartments
	getApartment: (id) ->
		_apartments[id]
	getTenant: (id) ->
		_tenants[id]
	getStreets: ->
		_streets
 emitChange: (event_e=CHANGE_EVENT)->
  @emit event_e
 addChangeListener: (callback,change_evt=CHANGE_EVENT) ->
  @on change_evt, callback
 removeChangeListener: (callback,change_evt=CHANGE_EVENT) ->
  @removeListener CHANGE_EVENT, callback

RegistrationStore.dispatchToken = AppDispatcher.register (payload) ->
 action = payload.action
 switch action.type
  when actions.CREATE_PROPERTY
   if action.data
   	_property = action.data
   RegistrationStore.emitChange()
   break
  when actions.ADD_APARTMENT
   if action.data
    _apartments[action.data.name] = action.data
   RegistrationStore.emitChange()
   break
  when actions.ADD_TENANT
   if action.data
    _tenants[action.data.name] = action.data
   RegistrationStore.emitChange()
   break
  when actions.RECEIVED_ZIP
   if action.data
    _streets = action.data
   RegistrationStore.emitChange 'streets' 
   break
  when actions.UPDATE_BUILDING_SIZE
   if action.data
    _new_property['floors'] = action.data.floors
    _new_property['units'] = action.data.units
   RegistrationStore.emitChange 'streets' 
   break
  when actions.ACTIVATE_APARTMENT
   if action.data
   	_active_apartment = action.data
   	if _apartments[action.data]?
   	else
   		apt = RegistrationStore.getNewApartment()
   		apt['name'] = action.data
   		_apartments[action.data] = apt
   if _steps == 3 then '' else _steps = 3
   RegistrationStore.emitChange 'streets' 
   break
  when actions.FIND_ZIP
   if action.data
    _new_property['zipcode'] = action.data.zip
    _new_property['address_line_1'] = action.data.building_no + " " + action.data.address_line_1
    _steps = _steps + 1
   RegistrationStore.emitChange 'streets' 
   break
  when actions.ADD_NEW_TENANT
   if action.data
    _aa = _active_apartment
    if _tenants[_aa]?
     _tenants[_aa].push action.data
    else
     _tenants[_aa] = [ action.data ]
   RegistrationStore.emitChange 'streets' 
   break
  when actions.RECORD_UNIT_INFORMATION
   if action.data
    _apartments[_active_apartment] = action.data
    _message = {time: Date.now()+6000, message: "Successfully saved " + _active_apartment}
   RegistrationStore.emitChange 'streets'
module.exports = RegistrationStore