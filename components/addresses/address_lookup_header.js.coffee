TextInput = require('../form_elements/text_input.js.coffee')
FormCard = require('../form_elements/form_card.js.coffee')
RegistrationViewActions = require('../../actions/registration_view_actions.js.coffee')
SubmitButton = require('../form_elements/submit_button.js.coffee')

AddressLookupHeader = React.createClass
	displayName: 'AddressLookupHeader'

	render: ->
		ad_sizes = {small: 6, medium: 8, large: 10}
		sizes = {small: 7, medium: 7, large: 7}
		<div className={"row address-header-section" + @props.visible}>
			<div className="small-11 columns">
				<FormCard>
					<TextInput initial_value={@props.data.address_line_1} label="Address" sizes={ad_sizes} classes="small-8 columns" labelClasses='right inline' />
					<TextInput initial_value={@props.data.zipcode} label="Zip Code" sizes={sizes} classes="small-4 columns" labelClasses='right inline' />
				</FormCard>
			</div>
		</div>

module.exports = AddressLookupHeader