AppDispatcher = require('../dispatcher/appdispatcher.js.coffee')
EventEmitter = require('events').EventEmitter
AppConstants = require('../constants/appConstants.js.coffee')
assign = require('object-assign')

CHANGE_EVENT = 'change'

actions = AppConstants.ActionTypes
_projects = []
_closed_projects = []
_completed_projects = []
_new_projects = []
_waiting_projects = []
_scheduled_projects = []
_completed_projects_ids = []
_new_projects_ids = []
_waiting_projects_ids = []
_scheduled_projects_ids = []
_closed_projects_ids = []
_step = 1
_apartments = []
_new_project_proto =
 project_target_type: null
 project_target_id: null
 description: null
_new_project = jQuery.extend(true, {}, _new_project)

update_project_array_if_necessary = (msg) ->
 # first check which array it is in currently
 pos = -1
 bucket = ''
 $.each ['new','scheduled','waiting','completed','closed'], (index,text) ->
  pos = eval("_" + text + "_projects_ids").indexOf(msg.id)
  if pos != - 1
   bucket = text
   false
 if pos == -1
  eval("_" + bucket_name(msg.status) + "_projects").unshift msg
  eval("_" + bucket_name(msg.status) + "_projects_ids").unshift msg.id
  return true
 current = eval("_" + bucket + "_projects")[pos]
 # then check if its already updated by another action
 if current.updated_at == msg.updated_at
  return false
 # then drop it into the correct bucket
 eval("_" + bucket + "_projects").splice pos, 1
 eval("_" + bucket_name(msg.status) + "_projects").unshift msg
 eval("_" + bucket + "_projects_ids").splice pos, 1
 eval("_" + bucket_name(msg.status) + "_projects_ids").unshift msg.id
 # return true if any changes were made or false if no changes were necessary
 return true
bucket_name = (status) ->
 switch status
  when 'Started' then 'new'
  when 'Waiting to Schedule' then 'waiting'
  when 'Completed' then 'completed'
  when 'Scheduled' then 'scheduled'
  when 'Confirmed & Completed' then 'closed'
ProjectStore = assign {}, EventEmitter.prototype,
 getStepInNewProject: ->
  _step
 getNewProject: ->
  _new_project
 getNewProjects: ->
  _new_projects
 getCompletedProjects: ->
  _completed_projects
 getScheduledProjects: ->
  _scheduled_projects
 getWaitingProjects: ->
  _waiting_projects
 getClosedProjects: ->
  _closed_projects
 getApartments: ->
  _apartments
 emitChange: (newevent = CHANGE_EVENT) ->
  @emit(newevent)
 addChangeListener: (change_event, callback) ->
  @on change_event, callback
 removeChangeListener: (change_event, callback) ->
  @removeListener change_event, callback

ProjectStore.dispatchToken = AppDispatcher.register (payload) ->
 action = payload.action
 switch action.type
  when actions.RECEIVED_PROJECTS
   if action.errors
    _error.push action.errors
   if action.data
    action.data.map (project) ->
     switch project.status
      when 'Completed' 
        _completed_projects.push project
        _completed_projects_ids.push project.id
      when 'Started'
       _new_projects.push project
       _new_projects_ids.push project.id
      when 'Waiting to Schedule'
       _waiting_projects.push project
       _waiting_projects_ids.push project.id
      when 'Scheduled'
       _scheduled_projects.push project
       _scheduled_projects_ids.push project.id
      when 'Completed & Confirmed'
       _closed_projects.push project
       _closed_projects_ids.push project.id
   ProjectStore.emitChange()
   break
  when actions.CHOSEN_PROJECT_AUDIENCE_TYPE
   _new_project.project_target_type = action.data
   if _new_project.project_target_type == 'portfolio'
    _step = 4
   else
    _step = 2
   ProjectStore.emitChange('new_project')
   break
  when actions.CHOSEN_PROJECT_AUDIENCE_ID
   _new_project.project_target_id = action.data
   if _new_project.project_target_type == 'building'
    _step = 4
   else
    _step = 3
   ProjectStore.emitChange('new_project')
   break
  when actions.RECEIVED_DIRECTORY
   if action.data && _step == 3
    _apartments = []
    action.data.map (apt) ->
     _apartments.push apt
   ProjectStore.emitChange('new_project')
   break
  when actions.CHANGE_PROJECT_AUDIENCE_ID
   _new_project.project_target_id = action.data
   _step = 4
   ProjectStore.emitChange('new_project')
   break
  when actions.UPDATE_PROJECT_DATES
   _new_project.from = action.data.from
   _new_project.to = action.data.to
   _step = 5
   ProjectStore.emitChange('new_project')
   break
  when actions.UPDATE_PROJECT_ACKNOWLEDGEMENT
   _step = 6
   _new_project.acknowledgement = action.data
   ProjectStore.emitChange('new_project')
   break
  when actions.UPDATE_PROJECT_MESSAGE
   _step = 5
   _new_project.description = action.data
   ProjectStore.emitChange('new_project')
   break
  when actions.CREATED_NEW_PROJECT
   _step = 1
   _apartments = []
   _new_project = jQuery.extend(true, {}, _new_project_proto);
   ProjectStore.emitChange('close_new_project')
   break
  when actions.CREATED_PROJECT
   if action.data
    _new_projects.unshift action.data
    _new_projects_ids.unshift action.data.id
    ProjectStore.emitChange()
   break
  when actions.CLEAR_NEW_PROJECT
   _step = 1
   _apartments = []
   _new_project = jQuery.extend(true, {}, _new_project_proto)
   ProjectStore.emitChange('close_new_project')
   break
  when actions.UPDATED_PROJECT
   if action.data
    if update_project_array_if_necessary action.data
     ProjectStore.emitChange()
module.exports = ProjectStore