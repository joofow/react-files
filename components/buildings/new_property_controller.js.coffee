AddressLookupHeader = require('../addresses/address_lookup_header.js.coffee')
AddressLookup = require('../addresses/address_lookup.js.coffee')
AddressListInternal = require('../addresses/address_list_internal.js.coffee')
AddressListExternal = require('../addresses/address_list_external.js.coffee')
ApartmentsOverview = require('../apartments/apartment_overview.js.coffee')
ApartmentSection = require('../apartments/apartment_section.js.coffee')
SectionHeader = require('../utilities/section_header.js.coffee')
RegistrationViewActions = require('../../actions/registration_view_actions.js.coffee')
RegistrationStore = require('../../stores/registration_store.js.coffee')
AddressDetails = require('../addresses/address_details.js.coffee')

setNewState = ->
	step: RegistrationStore.getStep()
	property: RegistrationStore.getProperty()
	apartment: RegistrationStore.getActiveApartment()
	tenants: RegistrationStore.getCurrentTenants()
	message: RegistrationStore.getSaveMessage()

NewPropertyController = React.createClass
	displayName: 'NewPropertyController'

	getInitialState: ->
		setNewState()

	componentDidMount: ->
		RegistrationStore.addChangeListener @_onChange
		RegistrationStore.addChangeListener @_newStreetsChange, 'streets'
	
	componentWillUnmount: ->
		RegistrationStore.removeChangeListener @_onChange
		RegistrationStore.removeChangeListener @_newStreetsChange, 'streets'

	_onChange: ->

	_newStreetsChange: ->
		@setState setNewState()

	_findBuilding: ->
		data =
 		zipcode: @refs.zipcode.state.value

	_createNewProperty: ->
		data =
 		zipcode: @refs.zipcode.state.value
		RegistrationViewActions.createProperty data

	_createNewApartment: ->
		data =
 		name: @refs.name.state.value
 		bedrooms: @refs.bedrooms.state.value
 		bathrooms: @refs.bathrooms.state.value
		RegistrationViewActions.createApartment data

	_createNewTenant: ->
		data =
 		first_name: @refs.first_name.state.value
 		last_name: @refs.last_name.state.value
 		phone: @refs.phone.state.value
 		email: @refs.email.state.value
		RegistrationViewActions.createTenant data

	_on_change: (e) ->
		RegistrationViewActions.activate_apartment e

	_saveInfo: (unit) ->
		RegistrationViewActions.save_information unit

	_saveAndConfirm: (unit) ->
		apartments = RegistrationStore.getAllApartments()
		tenants = RegistrationStore.getAllTenants()
		property = @state.property
		aa = RegistrationStore.getActiveApartmentNo()
		apartments[aa] = unit
		RegistrationViewActions.save_information_and_request_confirmation property, apartments, tenants, unit

	_clearPropertyForm: ->

	render: ->
		visible = switch @state.step
			when 1 then {step1: true, step2: false, step3: false }
			when 2 then {step1: false, step2: true, step3: false }
			when 3 then {step1: false, step2: false, step3: true }
			when 4 then {step1: false, step2: false, step3: false }
		<div className={ if @props.open then 'll-new-property' else 'hide'}>
			<SectionHeader title='New Property' exit={@props.close_new_property} />
			<AddressLookup visible={if visible["step1"] then '' else ' hide'} />
			<AddressLookupHeader data={@state.property} visible={if visible["step2"] || visible["step3"] || visible["step4"] then '' else ' hide'} />
			<div className="small-5 columns">
				<div className='row'>
					<AddressDetails data={@state.property} visible={if visible["step2"] || visible["step3"] then 'small-12 columns' else ' hide'}/>
					<ApartmentsOverview change_apt={@_on_change} data={@state.property} visible={if visible["step2"] || visible["step3"] then 'apartments-sketch-overview' else ' hide'}/>
				</div>
			</div>
			<ApartmentSection message={@state.message} saveInfo={ @_saveInfo } saveAndConfirm={ @_saveAndConfirm } apartment={@state.apartment} tenants={@state.tenants} visible={if visible["step3"]  then 'columns small-6 small-offset-1' else ' hide'}/>
		</div>
module.exports = NewPropertyController