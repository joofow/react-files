FeedStore = require('../../stores/feed_store.js.coffee')
NewActionCard = require('./new_action_card.js.coffee')
PersonActionMenu = require('../menus/person_action_menu.js.coffee')
PersonMenuItem = require('../menus/person_menu_item.js.coffee')

getFeedComponents = ->
 action: FeedStore.getNew()
 people: FeedStore.getPeople()

NewActionsSection = React.createClass
 displayName: 'NewActionsSection'
 
 getInitialState: ->
 	show_action: false
  getFeedComponents()

 componentDidMount: ->
  FeedStore.addChangeListener(@_onFeedChange, 'new_action')

 componentWillUnmount: ->
  FeedStore.removeChangeListener(@_onFeedChange, 'new_action')

 _onFeedChange: ->
  @setState getFeedComponents()

 _handleClick: ->
		@setState
			show_action: false
			action: {visible: false }

 switch: ->
  @setState 
  	show_action: !@state.show_action || true

 render: ->
 	visible = if @state.action.visible then "" else 'hide'
		<div className={visible}>
			{
				if @state.action.visible
					<PersonActionMenu removeAction={ @_handleClick } ref="person_menu" visible={@state.action.visible} person={ @state.people[@state.action.assigned_person_id] }>
						<PersonMenuItem key="message" click={@switch} hash="startNewConversation" id={@state.action.assigned_person_id}>Message</PersonMenuItem>
						<PersonMenuItem key="payment" click={@switch} hash="makeNewPayment" id={@state.action.assigned_person_id}>Payment</PersonMenuItem>
						<PersonMenuItem key="task" click={@switch} hash="assignNewTask" id={@state.action.assigned_person_id}> Task </PersonMenuItem>
						<PersonMenuItem key="reminder" click={@switch} hash="sendNewReminder" id={@state.action.assigned_person_id}>Reminder</PersonMenuItem>
					</PersonActionMenu>
			}
			<NewActionCard visible={@state.show_action} data={ @state.action } closing={@_handleClick}/>
		</div>
   
module.exports = NewActionsSection