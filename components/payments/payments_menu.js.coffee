MenuElement = require('../utilities/landlord_menu_element.js.coffee')
SearchBox = require('../utilities/search_box.js.coffee')

PaymentsMenu = React.createClass

	_change_section: (page) ->
		@props.goto page

	displayName: "PaymentsMenu"
	render: ->
		<div>
			<MenuElement name='Dashboard' click={@_change_section}/>
			<MenuElement name='Late' click={@_change_section}/>
			<MenuElement name='Received' click={@_change_section}/>
			<MenuElement name='Deposit' click={@_change_section}/>
			<MenuElement name='My Payment Info' click={@_change_section} />
		</div>

module.exports = PaymentsMenu