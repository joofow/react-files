NewTenantCard = require('./new_tenant_card.js.coffee')
TenantCard = require('./tenant_card.js.coffee')

TenantSection = React.createClass
	displayName: 'TenantSection'

	getInitialState: ->
		showing: false

	_add_new_tenant: ->
		@setState
			showing: true

	componentWillReceiveProps: (nextProps) ->
		if nextProps.data != @props.data
			@setState
				showing: false

	render: ->
		ad_sizes = {small: 4, medium: 4, large: 4}
		tenants = []
		tenants.push(<TenantCard tenant={tenant} />) for tenant in @props.data
		<div className={@props.visible}>
			<div className="small-12 columns">
				{
					if tenants.length > 0
						<div className="small-2 right columns">Tenants</div>
						<div className='small-10 columns'>
							{ tenants	}
						</div>
				}
				<a href='#' onClick={@_add_new_tenant} className={if @state.showing then 'hide' else ''}>+ Add New Tenant</a>
				<NewTenantCard showing={@state.showing} />
			</div>
		</div>

module.exports = TenantSection