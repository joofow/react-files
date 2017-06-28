# @cjsx React.DOM  
ConversationActionCreators = require('../../actions/conversations_view_actions.js.coffee')
PersonList = require('../people/person_list.js.coffee')
ContentEditable = require('../utilities/content_editable.js.coffee')
AddPeopleCard = require('../people/add_people_card.js.coffee')

NewConversationCard = React.createClass
  displayName: 'NewConversationCard'
  getInitialState: ->
    html: '<i>Type here</i>'
    messages: []
    recipient: (if @props.data.assigned_person_id == Array then @props.data.assigned_person_id else @props.data.assigned_person_id.toString().split(","))

  componentDidMount: ->
  
  _handleOnSubmit: (e) ->
    e.preventDefault()
    # the value of the message box input
    messageValue = @refs.message.lastHtml
    id = @state.recipient
    data =
      message: messageValue
      ids: id
    @setState 
      html: '<i>Type here</i>'
    ConversationActionCreators.createConversation data
    @props.close()

  addAdditionalPeople: (ids) ->
    idsNew = @state.recipient
    if idsNew.indexOf(ids) > -1 then '' else idsNew.push(ids)
    @setState
      recipient: idsNew

  changeHandler: (e) ->
    @setState
      html: e.target.value

  render: ->  
    visibility = if @props.data.visible
      ''
    else
      'hide '
    # here we use the calculated classes
    <div className={ visibility + "new-reminder"}>
      <form onSubmit={@_handleOnSubmit}>
        <div className="people-for">
           {
             if @state.recipient
               <PersonList keys={@state.recipient} />
             else
               ""
           }
          <AddPeopleCard data={@props.data.assigned_person_id} update={@addAdditionalPeople} />
        </div>
        <ContentEditable ref="message" html={@state.html} onChange={@changeHandler} id="message-editable" />
        <input type='submit' />
      </form>
    </div>

module.exports = NewConversationCard