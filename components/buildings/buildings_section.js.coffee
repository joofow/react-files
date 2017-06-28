BuildingCard = require('./building_card.js.coffee')
EmptyBuildingCard = require('./empty_building_card.js.coffee')

BuildingSection = React.createClass
	displayname: 'BuildingSection'

	getInitialState: ->
		show_action: false

	_activateBuilding: (id) ->
		@props.change_building(id)

	_add_to_list: (e) ->
		e.preventDefault()
		@props.start_page_action()		

	render: ->
		cards = if @props.buildings.length > 0
			((<BuildingCard click={@_activateBuilding} data={building} key={'building_' + @props.page_header + building.id} />) for building in @props.buildings)
		else
			((<EmptyBuildingCard key={'nobuilding' + num} /> for num in [1..1]))
		<section>
			<div>
				{ 
					if cards.length > 0
						"buidlings"
					else
						"Please Wait While We Load Your Buidlings"
				}
			</div>
		</section>

module.exports = BuildingSection