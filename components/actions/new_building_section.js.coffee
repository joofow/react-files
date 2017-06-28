SectionCard = require('../utilities/section_card.js.coffee')
AddNewBuilding = require('./add_new_building.js.coffee')
OpenNewBuildingCard = require('./open_new_building_card.js.coffee')
NewBuildingSection = React.createClass
 displayName: 'NewBuildingSection'
 
 getInitialState: ->
 	show_action: false
 	action: { visible: true }

 _handleClick: ->
		@setState
			show_action: true
			action: {visible: false }

 switch: ->
  @setState 
  	show_action: !@state.show_action || true

 render: ->
 	visible = if @state.action.visible then "" else 'hide'
 	<div>
 		{ 
 			if @state.action.visible
 				<SectionCard>
	 				<OpenNewBuildingCard closeDown={ @_handleClick } />
 				</SectionCard>
 		}
 		<AddNewBuilding show={@state.show_action} />
 	</div>
 
module.exports = NewBuildingSection