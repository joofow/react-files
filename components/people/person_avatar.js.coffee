# @cjsx React.DOM
PeopleActionCreators = require('../../actions/people_view_actions.js.coffee')

PersonAvatar = React.createClass
  displayName: 'PersonAvatar'
  
  handleClick: ->

  showMenu: ->
    PeopleActionCreators.openActions @props.data.id

  doNothing: ->
    console.log("stop pressing the button dumbass")
            
  render: ->
    # let's use this add-on to set the main div's class names
    cx = React.addons.classSet
    # it will apply every key which value equals true 
    # to the className attribute
    cardClasses = cx
      'card': true
      'active': if @props.data then @props.data.online == true else false
    # here we use the calculated classes      
    icon = if @props.data && @props.data.current_photo?
     '<img src=' + @props.data.current_photo + ' alt="name" width="100" />' 
    else
     '<i class="fa fa-user"></i>'
    <div className={if @props.menus then "left" else ""}>
      <a ref='person' onClick={ @showMenu } className={ if @props.menus then "" else "text-center" }>
       <div dangerouslySetInnerHTML={{__html: icon}}></div>
       <span className={cardClasses}></span>
      </a>
    </div>

module.exports = PersonAvatar