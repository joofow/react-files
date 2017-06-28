# @cjsx React.DOM  
ConversationsStore = require('../../stores/conversation_stores.js.coffee')
ConversationActionCreators = require('../../actions/conversations_view_actions.js.coffee')
ConversationCard = require('./conversation_card.js.coffee')

getAllConversations = ->
  conversations: ConversationsStore.getConversations()

ConversationsSection = React.createClass
  # Display name used for debugging
  displayName: 'ConversationsSection'

  getInitialState: ->
    getAllConversations()

  componentDidMount: ->
    ConversationsStore.addChangeListener(@_onChange)
    ConversationActionCreators.getAllConversations()

  componentWillUnmount: ->
    ConversationsStore.removeChangeListener(@_onChange)

  _onChange: ->
    @setState getAllConversations()

  render: ->
    conversationNode = @state.conversations.map (conversation) ->
      <ConversationCard key={conversation.id_time} data={conversation}/>
    noDataNode =
      <div className="warning">
        <span className="fa-stack">
          <i className="fa fa-meh-o fa-stack-2x"></i>
        </span>
        <h4>No conversations found...</h4>
      </div>
    <div>
      <div className="conversation-wrapper">
        {
          # If there are conversations render them...
          if @state.conversations.length > 0
            {conversationNode}
          # If has fetched data and no conversation found, render the 
          # warning message instead
          else
            {noDataNode}
        }
      </div>
    </div>

module.exports = ConversationsSection