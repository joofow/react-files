# @cjsx React.DOM  
ReminderCard = React.createClass
  displayName: 'ReminderCard'

  componentDidMount: ->
  
  render: ->
    # here we use the calculated classes
    <div>
       <span className="reminder-text">{@props.data.type.text}</span>
       <span className="reminder-task">{@props.data.task_id}</span>
       <span className="reminder-status">{@props.data.end_date}</span>
    </div>

module.exports = ReminderCard