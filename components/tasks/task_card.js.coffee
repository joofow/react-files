# @cjsx React.DOM  
PaymentRequestCard =  require('../payments/payment_request_card.js.coffee')

TaskCard = React.createClass
  displayName: 'TaskCard'

  componentDidMount: ->
  	
  createMarkup: (value) ->
    {__html: value}

  render: ->
    # here we use the calculated classes
    cx = React.addons.classSet
    cardClasses = cx
    	'task-card': true
     'complete': @props.data.type.completed
    html = "<div>" + @props.data.type.task_text + "</div>"
    <div className={cardClasses}>
      <h4>{(if @props.data.type.completed then "Task Requested" else (if @props.me then "Task Sent" else "Task Received"))}</h4>
       { <PaymentRequestCard data={@props.data} /> }
       <div className="task-text" dangerouslySetInnerHTML={@createMarkup(html)} />
       <span className={ if @props.data.completed_date then "task-image complete" else "task-image"}></span>
    </div>

module.exports = TaskCard