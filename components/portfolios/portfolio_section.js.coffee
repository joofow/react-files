BuildingsActions = require('../../actions/buildings_view_actions.js.coffee')
BuildingsStore = require('../../stores/building_store.js.coffee')
PortfolioCard = require('./portfolio_card.js.coffee')

getPortfolio = ->
	buildings: BuildingsStore.getAllBuildings()

PortfolioSection = React.createClass
 displayName: "PortfolioSection"

 getInitialState: ->
 	getPortfolio()
 
 componentDidMount: ->
 	BuildingsActions.getBuildings()
 	BuildingsStore.addChangeListener('change',@_onChange)

 _onChange: ->
 	@setState getPortfolio()

 render: ->
 	build = @state.buildings.map (building) ->
 		<PortfolioCard data={building} key={"building_" + building.id} />
 	if build.length == 0
 		<div>No Buildings in your portfolio</div>
 	else
 		<div>{ build }</div>

module.exports = PortfolioSection