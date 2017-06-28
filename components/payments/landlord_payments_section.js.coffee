PaymentsStore = require('../../stores/payments_store.js.coffee')
PaymentsActions = require('../../actions/payments_view_actions.js.coffee')
getPayments = ->
	payments: PaymentsStore.getPayments()

LandlordPaymentsSection = React.createClass
	displayName: 'LandlordPaymentsSection'

	getInitalState: ->
		getPayments()

	componentDidMount: ->
		PaymentsActions.getPayments()
		PaymentsStore.addChangeListener @_updatePayments

	_updatePayments:->
		@setState getPayments()
		
	_payments: ->
		@state.payments

	render: ->
		payments = @_payments.map (pay) ->
			<PaymentCard data={pay} />
		if payments.length == 0
			<div> It is empty in here </div>
		else
			{ payments }


module.exports = LandlordPaymentsSection