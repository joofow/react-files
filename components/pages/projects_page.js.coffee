ProjectMenu = require('../maintenance/project_menu.js.coffee')
ProjectHeaderSection = require('../maintenance/project_header_section.js.coffee')
ProjectDetailsSection = require('../maintenance/project_details_section.js.coffee')
BuildingSearchSection = require('../buildings/building_search_section.js.coffee')
DirectorySection = require('../directories/directory_section.js.coffee')

ProjectsPage = React.createClass
	displayName: 'ProjectsPage'

	getInitialState: ->
		directory_visible: false
		projects: @props.data_new
		waiting_projects: @props.data_waiting
		scheduled_projects: @props.data_scheduled
		completed_projects: @props.data_completed
		new_projects: @props.data_new
		closed_projects: @props.data_closed
		name: 'Open Projects'
		status: 'New'

	componentWillReceiveProps: ->
		@setState
			projects: @state.projects
			waiting_projects: @props.data_waiting
			scheduled_projects: @props.data_scheduled
			completed_projects: @props.data_completed
			new_projects: @props.data_new
			closed_projects: @props.data_closed

	_change_status: (status) ->
		if status != @state.status	
			projects = switch status
					when 'New' then @state.new_projects
					when 'Waiting to Schedule' then @state.waiting_projects
					when 'Scheduled' then @state.scheduled_projects
					when 'Completed' then @state.completed_projects
					when 'Completed & Confirmed' then @state.closed_projects
					else @state.new_projects
			@setState
				projects: projects
				status: status
	
	_change_section: (page) ->
		if page != @state.name
			@setState 
				name: page
				projects: switch page
					when 'Open Projects' then @props.data_new
					when 'Closed Projects' then @props.data_closed_projects
					when 'Calender' then @props.data_new_projects
					else @props.data_closed_projects

	_show_directory: ->
		@setState
			directory_visible: !@state.directory_visible

	render: ->
		<div className={@props.visible}>
			<div className='row'>
				<div className='small-12 columns text-center' data-cssid='posts-title-section'>
					Projects
				</div>
			</div>
			<div className='row'>
				<div className="medium-3 columns" data-cssid='payments-left-section'>
					<ProjectMenu page={@state.page} new_project={@_newProjectClick} move_page={@_change_section} current={@state.name} data={@state.projects} name={@state.name} status={@state.status} move_section={@_change_status} counts={@state}/>
				</div>
				<div className='medium-9 columns end'>
					<div className='row'>
						<div className='medium-12 columns page-header'>
							<ProjectHeaderSection name={@state.name} start_new_project={@props.show_new_project} tenant_directory={@_show_directory}/>
						</div>
					</div>
					<div className='row ll-feed-section'>
						<div className={ if @state.directory_visible then 'medium-9 columns' else 'small-11 small-centered columns'} data-cssid='building-main-feed'>
							<ProjectDetailsSection data={@state.projects} people={@props.people} apartments={@props.apartments} buildings={@props.buildings}/>
						</div>
						<div className={if @state.directory_visible then 'small-3 columns' else 'hide'} data-cssid='directory-section'>
							<BuildingSearchSection />
							<DirectorySection directory={@props.directory} />
						</div>
					</div>
				</div>
			</div>
		</div>

module.exports = ProjectsPage