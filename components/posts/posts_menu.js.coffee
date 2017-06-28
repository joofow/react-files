MenuElement = require('../utilities/landlord_menu_element.js.coffee')

PostsMenu = React.createClass
	displayName: 'PostsMenu'

	render: ->
		<div>
			<div className='page-header'><h2>Posts
				<i className='fa fa-plus-circle right' onClick={@_newPropertyClick}></i>
			</h2>
			</div>
			<MenuElement name='Portfolio' />
			<MenuElement name='Buildings' />
			<MenuElement name='Apartments' />
			<MenuElement name='Tenants' />			
		</div>

module.exports = PostsMenu