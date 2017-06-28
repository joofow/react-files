BuildingStore = require('../../stores/building_store.js.coffee')
BuildingViewActions = require('../../actions/buildings_view_actions.js.coffee')

getCurrentPage = ->
	visible_page: BuildingStore.getCurrentPage()

LandlordMenu = React.createClass
	displayName: 'LandlordMenu'

	getInitialState: ->
		getCurrentPage()

	componentDidMount: ->
		BuildingStore.addChangeListener 'new_page', @_showPage

	_showPage: ->
		@setState getCurrentPage()
			
	_changePage: (action) ->
		BuildingViewActions.changePage action

	render: ->
		self = @
		page = @state.visible_page
		icons = ['properties','payment','speaker','maintain','notice'].map (action) ->
			<div className={'text-center ll-logo title-' + action + '-logo' + if page == action then ' on-page' else ''} onClick={ self._changePage.bind(self,action) } key={action}></div>
		<div className='small-12 small-centered columns text-center'>
			{icons}
		</div>

module.exports = LandlordMenu