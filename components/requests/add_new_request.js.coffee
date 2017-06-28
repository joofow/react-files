RequestViewActions = require('../../actions/request_view_actions.js.coffee')
TextInput = require('../form_elements/text_input.js.coffee')
FormCard = require('../form_elements/form_card.js.coffee')
SectionCard = require('../utilities/section_card.js.coffee')
SelectInput = require('../form_elements/select_input.js.coffee')
AddPeopleCard = require('../people/add_people_card.js.coffee')
PersonList = require('../people/person_list.js.coffee')

AddNewRequest = React.createClass
 displayName: "AddNewBuilding"

 getInitialState: ->
 	recipient: []
 
 _formsubmit: (e) ->
 	e.preventDefault()
 	data =
 		apt_name: @refs.apt_name.state.value
 		about: @refs.about.state.value
 		recipients: @state.recipient
 	RequestViewActions.createRequest data
 	@props.change()

 addAdditionalPeople: (ids) ->
  idsNew = @state.recipient
  if idsNew.indexOf(ids) > -1 then '' else idsNew.push(ids)
  @setState
   recipient: idsNew

 render: ->
 	show = if @props.show then "" else 'hide'
  sizes = {small: 6, medium: 4, large: 4}
  # could technically draw down a list of constants here from a 'service request' table
 	# but for now happy to just write up the list here
 	options = [{name:"Payment Request",value:'payment'}, {name:"Service Request",value:"service"},{name:"Maintenance Request",value:"maintain"}]
 	<SectionCard classes={show}>
 		<FormCard action={ @_formsubmit }>
 			<div className="people-for">
     {
       if @state.recipient
         <PersonList keys={@state.recipient} />
       else
         ""
     }
 				<AddPeopleCard ref='apt_name' update={@addAdditionalPeople} />
 			</div>
 			<SelectInput options={options} label={"About"} sizes={sizes} total="10" />
 			<TextInput label={"Message"} sizes={sizes} total="10" />
 			<div className="row">
 				<div className="small-10">
 					<input type="submit" value="Submit" className="right" />
 				</div>
 			</div>
 		</FormCard>
 	</SectionCard>

module.exports = AddNewRequest