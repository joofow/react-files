# @cjsx React.DOM
MessageViewActions = require('../../actions/messages_view_actions.js.coffee')

MessageForm = React.createClass
  displayName: 'MessageForm'

  getInitialState: ->
    text: ''

  # Submit handler
  _handleOnSubmit: (e) ->
    e.preventDefault()

    # the value of the message box input
    messageValue = @refs.message.getDOMNode().value.trim()
    id = @props.id
    type = @props.type
    @setState 
      text: ''
    MessageViewActions.createMessage messageValue, type, id

  changeHandler: (e) ->
    @setState
      text: e.target.value

    # triggers it's custom onFormSubmit event passing searchValue 
  render: ->
    <div className="filter-wrapper">
      <div className="form-wrapper">
        <form onSubmit={@_handleOnSubmit}>
          <input ref="message" type='text' onChange={@changeHandler} placeholder="Write a message..." value={ @state.text} />
        </form>
      </div>
    </div>
module.exports = MessageForm