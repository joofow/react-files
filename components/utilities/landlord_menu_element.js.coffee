injectTapEventPlugin = require("react-tap-event-plugin");
injectTapEventPlugin()

MenuElement = React.createClass
	displayName: "MenuElement"

	_change_page: ->
		@props.click @props.name
		
	render:->
		<div className={"row panel " + if @props.name == @props.active then 'active-menu-element' else ''} onClick={@_change_page} onTouchTap={@_change_page}>
			<div className="medium-12 columns">
				<h4>{if @props.icon then <i className={'fa fa-'+@props.icon}></i> else ''} {@props.name}</h4>
				{ 
					if @props.name == @props.active
						@props.children 
					else
							""
					}
			</div>
		</div>

module.exports = MenuElement