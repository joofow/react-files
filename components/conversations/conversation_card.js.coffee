# @cjsx React.DOM  
ConversationCard = React.createClass
  displayName: 'ConversationCard'

  componentDidMount: ->
  
  render: ->
  	messages = if @props.data.messages.length > 0
  		<span className="reminder-text">{@props.data.messages[@props.data.messages.length-1].description}</span>
  	else if @props.data.payments.length > 0
  		<span className="payment-text">{@props.data.payments[@props.data.payments.length-1].description}</span>
  	else if @props.data.requests.length > 0
  		<span className="request-text">{@props.data.requests[@props.data.requests.length-1].description}</span>
  	else if @props.data.reminders.length > 0
  		<span className="reminder-text">{@props.data.reminders[@props.data.reminders.length-1].description}</span>
  	else if @props.data.notices.length > 0
  		<span className="notice-text">{@props.data.notices[@props.data.notices.length-1].description}</span>
  	else if @props.data.tasks.length > 0
  		<span className="task-text">{@props.data.tasks[@props.data.tasks.length-1].description}</span>
  	else
  		<span className="reminder-text">No Message</span>
   <div>
   	{ messages}
   </div>

module.exports = ConversationCard