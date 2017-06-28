# @cjsx React.DOM

PeopleStore = require('../../stores/people_store.js.coffee')
PeopleActionCreators = require('../../actions/people_view_actions.js.coffee')
PersonAvatar = require('./person_avatar.js.coffee')
AptAvatar = require('../apartments/apartment_avatar.js.coffee')
ApartmentStore = require('../../stores/apartment_store.js.coffee')
ApartmentActionCreators = require('../../actions/apartment_view_actions.js.coffee')

getPeopleFromStore = ->
  people: PeopleStore.getAll()
getApartmentStore = ->
  apartments: ApartmentStore.getApartments()

PeopleActionsCard = React.createClass
  # Display name used for debugging
  displayName: 'PeopleSection'

  # Invoked before the component is mounted and provides the initial 
  # state for the render method.
  getInitialState: ->
    getPeopleFromStore()
    getApartmentStore()

  # Invoked right after the component renders
  componentDidMount: ->
    PeopleStore.addChangeListener(@_onChange)
    ApartmentStore.addChangeListener(@_onChange)
    PeopleActionCreators.getPeople()
    ApartmentActionCreators.getApartments()

  _onChange: ->
    @setState getPeopleFromStore()
    @setState getApartmentStore()

  render: ->
    # The collection of PersonCard components we are going to display 
    # using the people stored in the component's state
    cardsNode = for person of @state.people
      # PersonCard component with a data property containing all the JSON 
      # attributes we are going to use to display it to the user
      p = @state.people[person]
      if p.me != true
        <PersonAvatar key={"person" + p.id} data={p} menus={true} />
    @state.apartments.map (apartment) ->
      cardsNode.unshift <AptAvatar key={"apt" + apartment.id} data={apartment} />
    cardsNode.push <a href="/people/invitation/new" key="add-to-apt"><div className="person-add right"><i className="fa fa-plus"></i></div></a>
    <div className="person-panel">{cardsNode}</div>

module.exports = PeopleActionsCard