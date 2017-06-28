
ProjectSummary = React.createClass
	displayName: 'ProjectSummary'
	render: ->
		values = @props.data[key] for key in @props.data
		<div>
		{values}
		</div>
module.exports = ProjectSummary
