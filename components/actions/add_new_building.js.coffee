BuildingViewActions = require('../../actions/buildings_view_actions.js.coffee')
TextInput = require('../form_elements/text_input.js.coffee')
FormCard = require('../form_elements/form_card.js.coffee')
SectionCard = require('../utilities/section_card.js.coffee')

AddNewBuilding = React.createClass
 displayName: "AddNewBuilding"

 _formsubmit: (e) ->
 	e.preventDefault()
 	data =
 		building_name: @refs.building_name.state.value
 		street_address1: @refs.street_address1.state.value
 		street_address2: @refs.street_address2.state.value
 		city: @refs.city.state.value
 		zipcode: @refs.zipcode.state.value
 		state: @refs.state.state.value
 		units: @refs.units.state.value
 	BuildingViewActions.createNewBuilding data

 render: ->
 	show = if @props.show then "" else 'hide'
 	sizes = {small: 6, medium: 4, large: 4}
 	<SectionCard classes={show}>
 		<FormCard action={ @_formsubmit }>
 			<TextInput label={"Building Name"} ref="building_name" sizes={sizes} total="10" /> 		
 			<TextInput label={"Street Address 1"} ref="street_address1" sizes={sizes} total="10" />
 			<TextInput label={"Street Address 2 "} ref="street_address2" sizes={sizes} total="10" />
 			<TextInput label={"City"} ref="city" sizes={sizes} total="10" />
 			<TextInput label={"Zipcode"} ref="zipcode" sizes={sizes} total="10"/>
 			<TextInput label={"State"} ref="state" sizes={sizes} total="10" />
 			<TextInput label={"Units in building"} ref="units" sizes={sizes} total="10" />
 			<div className="row">
 				<div className="small-10">
 					<input type="submit" value="Submit" className="right" />
 				</div>
 			</div>
 		</FormCard>
 	</SectionCard>

module.exports = AddNewBuilding