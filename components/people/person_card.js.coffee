# @cjsx React.DOM
PeopleActionCreators = require('../../actions/people_view_actions.js.coffee')

PersonCard = React.createClass
  displayName: 'PersonCard'
  
  handleClick: ->
    PeopleActionCreators.startNewConversation(@props.data.email)
        
  render: ->
    # let's use this add-on to set the main div's class names
    cx = React.addons.classSet
    # it will apply every key which value equals true 
    # to the className attribute
    cardClasses = cx
      'card': true
      'active': @props.data.online == true
    # here we use the calculated classes      
    <div className={cardClasses}>
      <div className="card-body">
        <ul className="no-bullet">
          <li ref='person' onClick={@handleClick}>{ @props.data.email }</li>
        </ul>
      </div>
    </div>
module.exports = PersonCard