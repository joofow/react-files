# @cjsx React.DOM
AppDispatcher = require('../../dispatcher/appdispatcher.js.coffee')
AppConstants = require('../../constants/appConstants.js.coffee')
WebAPIUtils = require('../../utils/webAPIutils.js.coffee')
MessageStore = require('../../stores/message_stores.js.coffee')
MessageActionCreators = require('../../actions/messages_view_actions.js.coffee')
FeedStore = require('../../stores/feed_store.js.coffee')
PeopleActionCreators = require('../../actions/people_view_actions.js.coffee')


getPeople = ->
	people = FeedStore.getPeople()

NewMessageCard = React.createClass
  displayName: 'NewMessageCard'

  getInitialState: ->
    id: @props.data
    text: ''
    getPeople()

  componentDidMount: ->
   PeopleStore.addChangeListener(@_onChange)

  _onChange: ->
    @setState getPeople()
  
  _handleOnSubmit: (e) ->
    e.preventDefault()

    # the value of the message box input
    messageValue = @refs.message.getDOMNode().value.trim()
    id = @props.id
    @setState 
      text: ''
    MessageActionCreators.postMessage id, messageValue

  changeHandler: (e) ->
    @setState
      text: e.target.value

    # triggers it's custom onFormSubmit event passing searchValue 
  render: ->
    <div className="filter-wrapper" key={@state.id}>
    		<div className="name-wrapper">
    			name: { @state.people[@state.id] }
    		</div>
      <div className="form-wrapper">
        <form onSubmit={@_handleOnSubmit}>
          <input ref="message" type='text' onChange={@changeHandler} placeholder="Write a message..." value={ @state.text} />
        </form>
      </div>
    </div>
    
module.exports = NewMessageCard