ProjectHeaderSection = React.createClass
	displayName: 'ProjectHeaderSection'

	render: ->
		<div>
			<div className='small-5 columns action-panel' onClick={@props.start_new_project}>Create New Project</div>
			<div className='small-5 columns action-panel' onClick={@props.tenant_directory}>Tenant Directory</div>
		</div>

module.exports = ProjectHeaderSection