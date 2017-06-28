# @cjsx React.DOM
PersonAvatar = require('../people//person_avatar.js.coffee')
TimeAgo = require('../../utils/timeago.js.coffee')
SinglePersonCard =  require('./single_person_card.js.coffee')
MessageSection = require('../messages/messages_section.js.coffee')
TaskCard = require('../tasks/task_card.js.coffee')
ReminderCard = require('../reminders/reminder_card.js.coffee')
ConversationCard = require('../conversations/conversation_card.js.coffee')
PaymentCard = require('../payments/payment_card.js.coffee')

FeedCard = React.createClass
 displayName: 'FeedCard'

 getInitialState: ->
  new_conversation: @props.data.new_conversation
 componentWillReceiveProps: ->
  @setState
   new_conversation: @props.data.new_conversation

 render: ->
  $avatar = @props.avatar
  $props = @props.data
  people_conv = if $props.people_in_conversations.length > 1
    $props.people_in_conversations.map (person) ->
      <SinglePersonCard name={$avatar[person.person_id].first_name} key={person.person_id + $props.key} />
  names = if $props.people_in_conversations.length > 1
    $props.people_in_conversations.map (person) ->
      $avatar[person.person_id].first_name
  cx = React.addons.classSet
  cardClasses = cx
   'unread': @state.new_conversation
   'pinned': if $avatar[ @props.data.person_id] then !$avatar[ @props.data.person_id].me else false
   'request': @props.data.my_conv
   'complete': if @props.data.type_type && @props.data.type.completed_date then true else false
  <div className="conversation-wrapper row">
    <div className={ (if @props.data.type_type then @props.data.type_type.toLowerCase() else "conversation") + " feed-card small-12 columns " + cardClasses }>
      <div className="row">
       <div className="feed-avatar small-2 columns">
        { if @props.data.type_type == 'Payment'
            <span className={ if @props.data.type_type && @props.data.type.completed_date then "payment-image complete" else "payment-image"}></span>
          else
            <PersonAvatar key={"person" + @props.data.person_id} data={@props.avatar[@props.data.person_id]} menus={false} />
        }
       </div>
       <div className="feed-content small-10 columns">
        <div className="feed-title">
          { unless @props.data.type_type == 'Payment'
            <span>{if @props.avatar[ @props.data.person_id] then @props.avatar[ @props.data.person_id].first_name else ""}</span>
            <span> to </span>
            { people_conv }
          }
         <TimeAgo time={@props.data.updated_at} />
        </div>
        <div className="feed-body">
          { 
            switch @props.data.type_type
              when 'Task'
                <TaskCard data={@props.data} names={names}/>
              when 'Reminder'
                <ReminderCard data={@props.data} names={names} />
              when 'Payment'
                <PaymentCard data={@props.data} names={names} name={@props.avatar[ @props.data.person_id].first_name || ""} me={@props.avatar[ @props.data.person_id].me || false}/>
              else
                <ConversationCard data={@props.data} />
            }
          { <MessageSection people={@props.avatar} key={@props.data.key} data={@props.data} open={false}/> }
        </div>
       </div>
      </div>
    </div>
  </div>

module.exports = FeedCard