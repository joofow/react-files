BuildingStore = require('../../stores/building_store.js.coffee')
BuildingViewActions = require('../../actions/buildings_view_actions.js.coffee')

BuildingSingularSection = React.createClass
	displayName: 'BuildingSingularSection'

	_onChange: ->
		@setState getBuilding()

	_changeFeedType: (type) ->
		BuildingViewActions.changeFeedType type

	render:->
		building = @props.building
		if building.length > 0
			building = building[0]
			<div>
				<div className='row upper-row'>
					<div className='small-5 columns text-center action-panel end' onClick={@props.start_page_action}>
						Create New Building
					</div>
				</div>
				<div className='row'>
					<div className='small-1 building-logo columns'></div>
					<div className='small-11 columns'>
						<h2><span>{building.address_line_1}</span><span className='smaller'>, {building.city_name}, {building.zipcode}</span></h2>
						<h4>{building.count} Occupants</h4>
					</div>
				</div>
			</div>
		else
			<div className='row upper-row'>
				<div className='small-5 columns text-center action-panel end' onClick={@props.start_page_action}>
					Create New Building
				</div>
			</div>

module.exports = BuildingSingularSection