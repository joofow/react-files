# @cjsx React.DOM
PersonAvatar = require('../people/person_avatar_clean.js.coffee')

PersonActionMenu = React.createClass
  # Display name used for debugging
  displayName: 'PersonActionMenu'

  # Invoked before the component is mounted and provides the initial 
  # state for the render method.

  render: ->
    visibility = if @props.visible
        'visible'
      else
        'hide'
    <div className="menu">
      <div className={visibility}>
        { 
          if @props.person
            <div className="personal-logo">
              <PersonAvatar key={"person" + @props.person.id} data={@props.person} menus={false} />
              <span onClick={ @props.removeAction } className='close-action'>&times;</span>
            </div>
        }
        <div className="action-choices row">
          { @props.children }
        </div>
      </div>
    </div>

module.exports = PersonActionMenu