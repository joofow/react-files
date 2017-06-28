TextInput = require('../form_elements/text_input.js.coffee')
FormCard = require('../form_elements/form_card.js.coffee')
RegistrationViewActions = require('../../actions/registration_view_actions.js.coffee')

AddressDetails = React.createClass
	displayName: 'AddressDetails'
	
	_form_submit: ->
		RegistrationViewActions.updateBuildingSize { floors: @refs.floors.state.value, units: @refs.units.state.value }

	render: ->
		ad_sizes = {small: 4, medium: 4, large: 4}		
		<div className={@props.visible}>
			<div className='row'>
				<div className='small-12 columns address-details'>
					{@props.data.address_line_1},NY,NY,{@props.data.zipcode}
				</div>
			</div>
			<div className='row'>
				<div className='small-10 small-offset-2 columns address-numbers'>
					<FormCard>
						<TextInput deliver_to_parent={@_form_submit} input_type='number' label="Floors" sizes={ad_sizes} classes="small-6 columns" labelClasses='right inline' />
						<TextInput deliver_to_parent={@_form_submit} input_type='number' label="Units" sizes={ad_sizes} classes="small-6 columns" labelClasses='right inline' />
					</FormCard>
				</div>
			</div>
		</div>

module.exports = AddressDetails