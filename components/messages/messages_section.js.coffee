# @cjsx React.DOM  
MessageCard = require('./message_card.js.coffee')
MessageForm = require('./message_form.js.coffee')
MessageStore = require('../../stores/message_stores.js.coffee')

getMessages = (type, id) -> 
  MessageStore.getMessages(type, id)

MessagesSection = React.createClass
  # Display name used for debugging
  displayName: 'MessagesSection'

  getInitialState: ->
    messages: getMessages(@props.type, @props.id)

  componentDidMount: ->
    MessageStore.addChangeListener @_new_messages, @props.type, @props.id

  componentWillUnmount: ->
    MessageStore.removeChangeListener @_new_messages, @props.type, @props.id    
  
  _new_messages: ->
    @setState 
      messages: getMessages @props.type,@props.id

  render: ->
    people = @props.people
    messageNode = []
    if @state.messages.length > 0
      messageNode = @state.messages.map (message) ->
        <MessageCard key={"message_" + Date.parse(message.updated_at)} name={people[message.person_id]} data={message} key={'msg_' + message.id}/>
    messageNode.push(<MessageForm id={@props.id} type={@props.type}/>)
    <div className="expand-conversations">
      { messageNode }
    </div>
    
module.exports = MessagesSection