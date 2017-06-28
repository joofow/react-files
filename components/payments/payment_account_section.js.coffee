AccountDetails = require('./payments_account_details.js.coffee')
EnterAccountDetails = require('./payment_create_account.js.coffee')
PaymentCreateCustomer = require('./payment_create_customer.js.coffee')
PaymentViewActions = require('../../actions/payments_view_actions.js.coffee')

PaymentAccountSection = React.createClass
	displayName: 'LL Account'

	_send_customer: (dob) ->
		PaymentViewActions.createCustomer dob

	render: ->
		<div>
			{ 
				if @props.person.verified
					<AccountDetails customer={@props.person.account} />
				else if @props.person.accounts
					<EnterAccountDetails person={@props.person} />
				else
					<PaymentCreateCustomer get_dob={@_send_customer}/>
				}
		</div>
module.exports = PaymentAccountSection