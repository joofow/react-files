MenuElement = require('../utilities/landlord_menu_element.js.coffee')
SectionMenuElement = require('../utilities/section_menu_element.js.coffee')
SearchBox = require('../utilities/search_box.js.coffee')

ProjectMenu = React.createClass
	displayName: "ProjectMenu"

	_start_new_project: ->
		@props.new_project()

	_change_section: (page) ->
		@props.move_page page

	render: ->
		<div className='maintenance-menu'>
			<MenuElement name='Open Projects' click={@_change_section} active={@props.current}>
				<dl className="ll-sub-nav">
					<SectionMenuElement name='New' switch_section={@props.move_section}	count={@props.counts.new_projects.length} current={ @props.status == 'New' }/>	
					<SectionMenuElement name='Waiting to Schedule' switch_section={@props.move_section}	count={@props.counts.waiting_projects.length}	current={ @props.status == 'Waiting to Schedule' } />	
					<SectionMenuElement name='Scheduled' switch_section={@props.move_section}	count={@props.counts.scheduled_projects.length}	current={ @props.status == 'Scheduled' } />	
					<SectionMenuElement name='Completed' switch_section={@props.move_section}	count={@props.counts.completed_projects.length}	current={ @props.status == 'Completed' } />	
					<SectionMenuElement name='Completed & Confirmed' switch_section={@props.move_section}	count={@props.counts.closed_projects.length}	current={ @props.status == 'Completed & Confirmed' }/>	
				</dl>
			</MenuElement>
			<MenuElement name='Closed Projects' click={@_change_section} active={@props.current}/>
			<MenuElement name='Calendar' click={@_change_section} active={@props.current}/>
		</div>

module.exports = ProjectMenu
