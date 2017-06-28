PersonList = require('../people/person_list.js.coffee')
ContentEditable = require('../utilities/content_editable.js.coffee')
TaskActionCreators = require('../../actions/tasks_view_actions.js.coffee')
AddPeopleCard = require('../people/add_people_card.js.coffee')

NewTaskCard = React.createClass
	displayName: "NewTaskCard"

	getInitialState: ->
  recipient: (if @props.data.assigned_person_id == Array then @props.data.assigned_person_id else @props.data.assigned_person_id.toString().split(","))
		text: ''
		end_date: ''

 _handleOnSubmit: (e) ->
  e.preventDefault()
   # the value of the message box input
  taskValue = @refs.task.lastHtml
  id = @state.recipient
  end_date = @refs.date.getDOMNode().value
  data =
   task_text: taskValue
   ids: id
   end_date: end_date
  @setState 
   html: '<i>Type here</i>'
  TaskActionCreators.createTask data
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
  <div className={ visibility + "new-task"}>
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
			 <div>
				 <ContentEditable ref="task" html={@state.html} onChange={@changeHandler} id="task-editable" />
          <input ref="date" type="date" />
			 </div>
			 <input type="submit" name="submit" />
		 </form>
	 </div>

module.exports = NewTaskCard