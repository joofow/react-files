TextBox =  require('../utilities/text_box.js.coffee')
SelectBox = require('../utilities/select_box.js.coffee')
PeopleStore = require('../../stores/people_store.js.coffee')
ContentEditable = require('../utilities/content_editable.js.coffee')
PeopleActionCreators = require('../../actions/people_view_actions.js.coffee')

getPeople = ->
	people: PeopleStore.getAllArray()
	visible: false
	html: "<i>add person</i>"
	people_max: PeopleStore.getAllArray()

getOnlyPeople = ->
	people: PeopleStore.getAllArray()
	people_max: PeopleStore.getAllArray()

AddPeopleCard = React.createClass
	displayName: 'AddPeopleCard'

	getInitialState: ->
		getPeople()
	
	componentDidMount: ->
		PeopleStore.addChangeListener @_onChange
		PeopleActionCreators.getPeople()

	_onChange: ->
		@setState getOnlyPeople()	
	addingPerson: (id) ->
		@props.update(id)
		@setState
			visible: false
			html: "<i>add person</i>"
	matchingPeople: (value) ->
		newPeople = []
		final = []
		tmp = document.createElement("DIV")
  tmp.innerHTML = value
  justText = (tmp.textContent || tmp.innerText || "").trim()
  if justText.length > 0
	  newPeople = @state.people_max.map (person) ->
	  	testPattern = new RegExp(justText)
	 		if testPattern.test(person.first_name) || testPattern.test(person.last_name) || testPattern.test(person.set_nickname)
	 			person
	 	(if person? then final.push(person) else console.log('rstest')) for person in newPeople
	  final
	 else
	 	@state.people_max

 changeHandler: (e) ->
  @setState
    html: e.target.value
    people: @matchingPeople(e.target.value)
    visible: true
 
 _moveDown: (e) ->
 	console.log("moving down")

	render: ->
		<div>
			<ContentEditable ref="new_person" html={@state.html} onChange={@changeHandler} id="person-editable" />
			<SelectBox click={@addingPerson} visibility={@state.visible} data={@state.people} onKeyDown={@_moveDown} lookup={'set_nickname'}/>
		</div>

module.exports = AddPeopleCard