BuildingSection = require('../buildings/buildings_section.js.coffee')
DirectorySection = require('../directories/directory_section.js.coffee')
BuildingSingularSection = require('../buildings/buildings_singular_section.js.coffee')
BuildingInformation = require('../buildings/building_information.js.coffee')
AddNewBuilding = require('../actions/add_new_building.js.coffee')
BuildingViewActions = require('../../actions/buildings_view_actions.js.coffee')
BuildingSearchSection = require('../buildings/building_search_section.js.coffee')
SearchBox = require('../utilities/search_box.js.coffee')

PropertiesPage = React.createClass
	displayName: 'BuildingPage'

	getInitialState: ->
		directory_visible: false
		buildings: @props.data.buildings
		filtered_buildings: @props.data.buildings

	_search: (exp) ->
		re = new RegExp(exp,"g");
		temp_state = @state.buildings.filter (b) ->
			(b.address_line_1 && b.address_line_1.match re) || (b.address_line_2 && b.address_line_2.match re) || (b.city_name && b.city_name.match re) || (b.zipcode && b.zipcode.toString().match re)
		@setState
			filtered_buildings: temp_state

	_open_new_building: (id) ->
		BuildingViewActions.getDirectory id
		BuildingViewActions.getBuilding id

	_add_new_building:->
		@props.show_new_property()

	_show_directory: ->
		@setState
			directory_visible: !@state.directory_visible

	render: ->
		<div className={@props.visible + ' row'}>
			<div className='small-12 columns'>
				<div className='row'>
					<div className='small-12 columns' data-cssid='posts-title-section'>
						<div className='row'>
							<div className='small-12 columns text-center'>
								Properties
								<span className='right tenant-dir-button' onClick={@_show_directory}>Tenant Directory</span>
							</div>
						</div>
					</div>
				</div>
				<div className='row'>
					<div className='medium-3 columns' data-cssid='building-left-section'>
						<div className='page-header row'>
							<SearchBox search={@_search} />
						</div>
						<BuildingSection buildings={ @state.filtered_buildings} change_building={@_open_new_building} />
					</div>
					<div className='medium-9 columns'>
						<div className='row'>
							<div className='medium-12 columns' data-cssid='building-title-section'>
								<BuildingSingularSection building={@props.data.building} start_page_action={@_add_new_building}/>
							</div>
						</div>
						<div className='row ll-feed-section'>
							<div className={if @state.directory_visible then 'medium-9 columns' else 'small-12 columns'} data-cssid='building-main-feed'>
								<BuildingInformation data={@props.data.building} />
							</div>
							<div className={if @state.directory_visible then 'small-3 columns' else 'hide'} data-cssid='directory-section'>
								<BuildingSearchSection />
								<DirectorySection directory={@props.data.directory} />
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

module.exports = PropertiesPage