# @cjsx React.DOM
ApartmentActionCreators = require('../../actions/apartment_view_actions.js.coffee')
PersonActionMenu = require('../menus/person_action_menu.js.coffee')
PersonMenuItem = require('../menus/person_menu_item.js.coffee')

ApartmentAvatar = React.createClass
  displayName: 'ApartmentAvatar'

  getInitialState: ->
    name: @props.data.name
    id: @props.data.id
  
  showMenu: ->
    ApartmentActionCreators.openActions @props.data.id

  componentDidmount: ->
            
  render: ->
    <div className="left">
      <a onClick={@showMenu} className="text-center">
        <i className="fa fa-users"></i>
        { @props.data.name }
      </a>
    </div>

module.exports = ApartmentAvatar