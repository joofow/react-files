SectionCard = require('../utilities/section_card.js.coffee')
AddNewRequest = require('./add_new_request.js.coffee')
OpenNewRequestCard = require('./open_new_request_card.js.coffee')

getStates = ->
	show_action: false
	action: { visible: true }

NewRequestSection = React.createClass
	displayName: 'NewRequestSection'
 
 getInitialState: ->
 	getStates()

 _handleClick: ->
		@setState
			show_action: true
			action: {visible: false }

 switch: ->
  @setState 
  	show_action: !@state.show_action

 render: ->
 	visible = if @state.action.visible then "" else 'hide'
 	<div>
 		{ 
 			if @state.action.visible
 				<SectionCard>
	 				<OpenNewRequestCard closeDown={ @_handleClick } />
 				</SectionCard>
 		}
 		<AddNewRequest show={@state.show_action} change={@switch} />
 	</div>
 
module.exports = NewRequestSection