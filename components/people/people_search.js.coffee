# @cjsx React.DOM
PeopleSearch = React.createClass
  displayName: 'PeopleSearch'

  # Submit handler
  _handleOnSubmit: (e) ->
    e.preventDefault()

    # the value of the search box input
    searchValue = @refs.search.getDOMNode().value.trim()

    # triggers it's custom onFormSubmit event passing searchValue 
    @props.onFormSubmit(searchValue)

  render: ->
    <div className="row">
      <div className="large-12 columns">
        <form onSubmit={@_handleOnSubmit}>
          <input ref="search" placeholder="Search people..." type="search"/>
        </form>
      </div>
    </div>

module.exports = PeopleSearch