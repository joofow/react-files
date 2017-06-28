# @cjsx React.DOM
PeopleStore = require('../../stores/people_store.js.coffee')
PeopleActionCreators = require('../../actions/people_view_actions.js.coffee')
PersonCard = require('./person_card.js.coffee')
PeopleSearch = require('./people_search.js.coffee')
PersonAvatar = require('./person_avatar_clean.js.coffee')

getPeopleFromStore = ->
  people: PeopleStore.getAll()

PeopleSection = React.createClass
  # Display name used for debugging
  displayName: 'PeopleSection'

  # Invoked before the component is mounted and provides the initial 
  # state for the render method.
  getInitialState: ->
    getPeopleFromStore()

  # Invoked right after the component renders
  componentDidMount: ->
    PeopleStore.addChangeListener(@_onChange)
    PeopleActionCreators.getPeople()

  _onChange: ->
    @setState getPeopleFromStore()

  # Handler for the submit event on the PeopleSearch component
  _handleOnSearchSubmit: (search) ->
    console.log(search)
  # How the component is going to be rendered to the user depending on it's 
  # props and state...
  render: ->
    # The collection of PersonCard components we are going to display 
    # using the people stored in the component's state
    $people = @state.people
    cardsNode = []
    for person of $people
      # PersonCard component with a data property containing all the JSON 
      # attributes we are going to use to display it to the user
      p = $people[person]
      cardsNode.push(<PersonAvatar key={"person" + p.id} data={p} menus={true} />)
    # HTML displayed if no people found in it's state
    noDataNode =
      <div className="warning">
        <span className="fa-stack">
          <i className="fa fa-meh-o fa-stack-2x"></i>
        </span>
        <h4>No people found...</h4>
      </div>
    <div className="cards-wrapper name-section">
      {
        # If there are people render the cards...
        if cardsNode.length > 0
          {cardsNode}
        # If has fetched data and no people found, render the 
        # warning message instead
        else if @state.didFetchData
          {noDataNode}
      }
    </div>

module.exports = PeopleSection