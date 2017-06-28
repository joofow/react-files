SectionHeader = require('../utilities/section_header.js.coffee')
ProjectsStore = require('../../stores/project_store.js.coffee')
ProjectSummary = require('./project_summary.js.coffee')
ProjectChooseAudienceType = require('./project_choose_audience_type.js.coffee')
ProjectChooseAudience = require('./project_choose_audience.js.coffee')
ProjectChooseTimeFrame = require('./project_choose_time_frame.js.coffee')
ProjectMessage = require('./project_message.js.coffee')
ProjectNeedAcknowledgement = require('./project_need_acknowledgement.js.coffee')
ProjectChooseType = require('./project_choose_type.js.coffee')
ProjectViewActions = require('../../actions/project_view_actions.js.coffee')
ProjectConfirmation = require('./project_confirmation.js.coffee')

setNewState = ->
	step: ProjectsStore.getStepInNewProject()
	new_project: ProjectsStore.getNewProject()
	apartments: ProjectsStore.getApartments()

NewProjectController = React.createClass
	displayName: 'NewProjectController'
	
	getInitialState: ->
		setNewState()

	componentDidMount: ->
		ProjectsStore.addChangeListener 'new_project', @_onChange
		ProjectsStore.addChangeListener 'close_new_project', @_closeNewProject
	
	componentWillUnmount: ->
 	ProjectsStore.removeChangeListener 'new_project', @_onChange
		ProjectsStore.removeChangeListener 'close_new_project', @_closeNewProject

 _closeNewProject: ->
  @props.close_new_project()
  @setState setNewState()

 _clearNewProject: ->
  ProjectViewActions.clearNewProject()

	_onChange: ->
		@setState setNewState()

	_chosen_audience_type: (type) ->
		ProjectViewActions.chosenAudienceType type

	_chosen_building_target: (id) ->
		if @state.step == 2
			ProjectViewActions.chosenAudienceId id
		else if @state.step == 3
			ProjectViewActions.changeAudienceId id
	
	_update_dates: (data) ->
		ProjectViewActions.updateDates data
	
	_change_acknowledge: (data) ->
		ProjectViewActions.updateAcknowledgement data

	_update_message: (data) ->
		ProjectViewActions.updateMessage data

	_submit_project: ->
		ProjectViewActions.createNewProject @state.new_project
 
 _submit_message: (data) ->
  ProjectViewActions.updateMessage data

	render: ->
		<div className={ if @props.open then 'll-new-property' else 'hide'}>
			<SectionHeader title='New Project' exit={@_clearNewProject} />
			<ProjectSummary data={@state.new_project}/>
			<ProjectChooseAudienceType data={@state.new_project} typeChoosen={@_chosen_audience_type} visible={ if [1].indexOf(@state.step) > -1 then 'visible' else 'hide'} />
			<ProjectChooseAudience apartments={@state.apartments} step={@state.step} idChoosen={@_chosen_building_target} data={@state.new_project} visible={ if [2,3].indexOf(@state.step) > -1 then 'visible' else 'hide' } people={@props.people} buildings={@props.buildings} />
			<ProjectChooseType visible={ if [1,2,3,4,5,6,7].indexOf(@state.step) > -1 then 'visible' else 'hide' } />
			<ProjectMessage value={@state.new_project.message} visible={ if [4].indexOf(@state.step) > -1 then 'visible' else 'hide' } submit_message_text={@_submit_message} />
			<ProjectConfirmation data={@state.new_project} visible={ if [5].indexOf(@state.step) > -1 then 'visible' else 'hide' } confirmed={@_submit_project} />
		</div>

module.exports = NewProjectController