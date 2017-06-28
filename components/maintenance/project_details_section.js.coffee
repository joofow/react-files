ProjectFeedCard = require('../maintenance/project_feed_card.js.coffee')
SectionCard = require('../utilities/section_card.js.coffee')

ProjectDetailsSection = React.createClass
	displayName: 'ProjectDetailsSection'

	render: ->
		if @props.data? && @props.people? && @props.buildings.length > 0 && @props.apartments.length > 0
			lookup_apartments = {}
			lookup_buildings = {}
			people = @props.people
			lookup_apartments[apartment.id] = apartment for apartment in @props.apartments
			lookup_buildings[building.id] = building for building in @props.buildings
			cards = ((<ProjectFeedCard people={@props.people} data={m} key={'maintenance_card_' + m.id} apartments={@props.apartments} buildings={@props.buildings} building={ lookup_buildings[if m.project_target_type == 'Building' then m.project_target_id else (if m.project_target_type =='Apartment' then lookup_apartments[m.project_target_id].bid else people[m.project_target_id].building_id)]} apartment={ if ['Apartment','Person'].indexOf(m.project_target_type) > -1 then (lookup_apartments[if m.project_target_type =='Apartment' then m.project_target_id else people[m.project_target_id].apartment_id]) else null} target={ [if m.project_target_type == 'Apartment' then lookup_apartments[m.project_target_id] else (if m.project_target_type == 'Building' then lookup_buildings[m.project_target_id] else people[m.project_target_id])]}/>) for m in @props.data)
		<SectionCard classes='maintenance-section row'>
			<div className='medium-12 columns'>
			{ 
				if cards?
					"this is it"
				else
					"Please Wait While We Load Your Projects"
			}
			</div>
		</SectionCard>


module.exports = ProjectDetailsSection