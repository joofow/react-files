TenantSection = require('../tenants/tenant_section.js.coffee')
UnitSection = require('../apartments/unit_section.js.coffee')
AlertBox = require('../utilities/alert_box.js.coffee')
ApartmentSection = React.createClass
	displayName: 'ApartmentSection'
	
	getInitialState: ->
		showing: 'unit'

	_switchToUnit: ->
		@setState
			showing: 'unit'

	_getUnitData: ->
		console.log 'get_date'

	_switchToTenant: ->
		@setState
			showing: 'tenant'

	_saveCurrent: (data) ->
		@props.saveInfo @_getUnitData()

	_saveCurrentAndRequestConfirmation: (data) ->
		@props.saveAndConfirm @_getUnitData()

	render: ->
		<div className={@props.visible}>
			<div className={'ll-apartment-section row'}>
				<div className="small-4 columns">{"Apartment " + @props.apartment.name }</div>
				<div className={"small-4 columns" + (if @state.showing == 'unit' then ' active' else '')} onClick={@_switchToUnit}>UNIT INFORMATION</div>
				<div className={"small-4 columns" + (if @state.showing == 'tenant' then ' active' else '')} onClick={@_switchToTenant}>TENANT INFORMATION</div>
			</div>
			<div className='small-12'>
				<AlertBox data={@props.message} />
			</div>
			<UnitSection apt={@props.apartment} visible={if @state.showing == 'unit' then 'row ll-unit-section' else ' hide'} />
			<TenantSection visible={if @state.showing == 'tenant' then 'row ll-unit-section' else ' hide'} data={@props.tenants}/>
			<div className="row">
				<div className='small-8 small-offset-2 columns ll-save'>
					<a href='#' onClick={@_saveCurrent}>Save Information</a>
				</div>
			</div>
			<div className='row'>
				<div className='small-8 small-offset-2 columns ll-save ll-request'>
					<a href='#' onClick={@_saveCurrentAndRequestConfirmation}>Request Confirmation</a>
				</div>
			</div>
		</div>

module.exports = ApartmentSection