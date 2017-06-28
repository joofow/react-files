TenantCard = React.createClass
	displayName: 'TenantCard'

	render: ->
		<div className='small-12 columns end'>
			<div className='tenant-name'>{@props.tenant.first_name + " " + @props.tenant.last_name }</div>
		</div>
module.exports = TenantCard