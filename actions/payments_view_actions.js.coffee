appDispatcher = require('../dispatcher/appdispatcher.js.coffee')
appConstants = require('../constants/appConstants.js.coffee')
WebAPIUtils = require('../utils/webAPIutils.js.coffee')

ActionTypes = appConstants.ActionTypes

module.exports =

  createPayment: (payment) ->
    data =
      payment: payment
    appDispatcher.handleViewAction
      type: ActionTypes.POST_PAYMENT
    WebAPIUtils.postNewPayment data
    
  getPayments:  ->
    appDispatcher.handleViewAction
      type: ActionTypes.GET_PAYMENTS
    WebAPIUtils.getPayments()

  updatePayment: (payment) ->
    data = 
      payment: payment
    WebAPIUtils.updatePayment data

  createCustomer: (dob) ->
    WebAPIUtils.createCustomer dob      