appDispatcher = require('../dispatcher/appdispatcher.js.coffee')
appConstants = require('../constants/appConstants.js.coffee')

ActionTypes = appConstants.ActionTypes

module.exports =

	receivedPayment: (payment) ->
		appDispatcher.handleServerAction
			type: ActionTypes.RECEIVED_PAYMENT
			data: payment
			
	receivedPayments: (data, status, object) ->
		appDispatcher.handleServerAction
			type: ActionTypes.RECEIVED_PAYMENTS
			data: data

	recieveCreatedPayment: (data, status, object) ->
		appDispatcher.handleServerAction
			type: ActionTypes.RECEIVED_CREATED_PAYMENT
			data: if status == 'success' then data else null
			errors: if status == 'success' then null else data.errors
	
	updatedPayment: (data) ->
		appDispatcher.handleServerAction
			type: ActionTypes.UPDATED_PAYMENT
			data: data