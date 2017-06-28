# @cjsx React.DOM

PersonAvatar = React.createClass
  displayName: 'PersonAvatar'
  
  handleClick: ->

  showMenu: ->
    @refs.person_menu.switch()

  doNothing: ->
    console.log("stop pressing the button dumbass")
            
  render: ->
    # let's use this add-on to set the main div's class names
    cx = React.addons.classSet
    # it will apply every key which value equals true 
    # to the className attribute
    cardClasses = cx
      'card': true
      'active': @props.data.online == true
    # here we use the calculated classes      
    icon = if @props.data.current_photo
     '<img src=' + @props.data.current_photo + ' alt="name" width="100" />' 
    else
     '<i class="fa fa-user"></i>'
    <a ref='person' onClick={ if @props.menus == true then @showMenu else @doNothing } className={ if @props.menus == true then "text-center inline-display" else "" }>
     <div dangerouslySetInnerHTML={{__html: icon}}></div>
     <div>{@props.data.first_name }</div>
     <span className={cardClasses}></span>
    </a>

module.exports = PersonAvatar