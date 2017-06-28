# @cjsx React.DOM  
FayeActionCreators = require('../actions/faye_view_actions.js.coffee')

FayeInit = React.createClass
	displayName: 'FayeInit'
	getInitialState: ->
		loaded: false

	componentDidMount: ->
		FayeActionCreators.connect_client()

	render: ->
		<div></div>

module.exports = FayeInit