TextInput = require('../form_elements/text_input.js.coffee')
FormCard = require('../form_elements/form_card.js.coffee')
SubmitButton = require('../form_elements/submit_button.js.coffee')

PaymentCreateCustomer = React.createClass
	displayName: 'CreateCustomer'

	_submitDetails: ->
		@props.get_dob @refs.dob.value

	render: ->
		sizes = {small: 6, medium: 6, large: 6}
		<div>
				<h2>Confirm Details:</h2>
				<FormCard action={@_submitDetails}>
					<div className='row'><TextInput total='10' label='DOB' ref='dob' sizes={sizes} /></div>
					<div className='row'><SubmitButton classes='small-10 columns' text='Submit' next={@_submitDetails}/></div>
				</FormCard>
		</div>
module.exports = PaymentCreateCustomer