
PostSummary = React.createClass
	displayName: 'PostSummary'
	render: ->
		values = @props.data[key] for key in @props.data
		<div className={'small-8 small-offset-2 columns ' + @props.visible }>
			{ values }
		</div>
module.exports = PostSummary
