TextInput = require('../form_elements/text_input.js.coffee')
FormCard = require('../form_elements/form_card.js.coffee')
SubmitButton = require('../form_elements/submit_button.js.coffee')
ErrorCard = require('../form_elements/error_card.js.coffee')
PaymentViewActions = require('../../actions/payments_view_actions.js.coffee')
SelectInput = require('../form_elements/select_input.js.coffee')

EnterAccountDetails = React.createClass
	displayName: 'CreateAccount'
	render: ->
		options = [{value: "checking", name: "Checking"},{value: "savings", name: "Savings"}]
		sizes = {small: 6, medium: 6, large: 6}
		<div>
			<FormCard>
				<div className='row'><TextInput total='10' label='Routing Number' ref='route_no' sizes={sizes} /></div>
				<div className='row'><TextInput total='10' label='Account Number' ref='account_no' sizes={sizes} /></div>
				<div className='row'><TextInput total='10' label='Account Name' ref='account_name' sizes={sizes} /></div>
				<div className='row'><SelectInput total='10' sizes={sizes} label="Account Type" options={options} ref="type" classes='row'/></div>
				<div className='row'><SubmitButton classes='small-10 columns' text='Submit' /></div>
			</FormCard>
		</div>
module.exports = EnterAccountDetails