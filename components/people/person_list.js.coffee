# @cjsx React.DOM
PeopleStore = require('../../stores/people_store.js.coffee')
PersonItem = require('./person_item.js.coffee')

getPeopleFromStore = ->
	people: PeopleStore.getAll()

PersonList = React.createClass
	displayName: "PersonList"

	getInitialState: ->
		getPeopleFromStore()

	render: ->
		$people = @state.people
		<span>
		{
			if @props.keys && @state.people
				names_in_use = @props.keys.map (id) ->
					console.log(id)
					<PersonItem data={$people[parseInt(id)]} />			
				{ names_in_use }
			else
				"If this is showing, you are doing it wrong."
		}
		</span>
module.exports = PersonList 