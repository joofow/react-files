# app/assets/javascripts/react/people/people_search.js.coffee

# @cjsx React.DOM

@ConversationsSearch = React.createClass
  displayName: 'ConservationsSearch'

  # Submit handler
  _handleOnSubmit: (e) ->
    e.preventDefault()

    # the value of the search box input
    searchValue = @refs.search.getDOMNode().value.trim()

    # triggers it's custom onFormSubmit event passing searchValue 
    @props.onFormSubmit(searchValue)

  render: ->
    <div className="filter-wrapper">
      <div className="form-wrapper">
        <form onSubmit={@_handleOnSubmit}>
          # ref attribute is used to reference elements in the 
          # component by @refs
          <input ref="search" placeholder="Search conversations..." type="search"/>
        </form>
      </div>
    </div>