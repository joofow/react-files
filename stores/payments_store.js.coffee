AppDispatcher = require('../dispatcher/appdispatcher.js.coffee')
EventEmitter = require('events').EventEmitter
appConstants = require('../constants/appConstants.js.coffee')
assign = require('object-assign')

actions = appConstants.ActionTypes

CHANGE_EVENT = 'change'

_payments = []
_outstanding = [] 
_received = []
_deposit = []
_sorted_list = []

PaymentsStore = assign {}, EventEmitter.prototype,

 getPayments: ->
  _payments
 getDeposit: ->
  _deposit
 getOutstanding: ->
  _outstanding
 getReceived: ->
  _received
 getLast: ->
  _payments[_payments.length-1]
 getPayment: (i) ->
  _payments[i]
 emitChange: ->
  @emit(CHANGE_EVENT)
 addChangeListener: (change_event, callback) ->
  @on change_event, callback
 removeChangeListener: (change_event, callback) ->
  @removeListener change_event, callback
 addToFeed: (tobeadded, type) ->
  _payments[Date.parse(tobeadded.updated_at || tobeadded.created_at)] = tobeadded
 order_list: ->
  nodes = for item of _payments
    item
  nodes.sort (a,b) ->
    b-a
  _sorted_list = nodes

PaymentsStore.dispatchToken = AppDispatcher.register (payload) ->
 action = payload.action
 switch action.type
  when actions.MAKE_NEW_PAYMENT
   PaymentsStore.emitChange()
   break
  when actions.RECEIVED_NEW_PAYMENT
   PaymentsStore.emitChange()
   break
  when actions.RECEIVED_PAYMENTS
   if action.data
     _directory = []
     action.data.map (payment) ->
      if payment.payment_type == 'Deposit'
        _deposit.push payment
      else if payment.status == 'Outstanding' and payment.payment_type == 'Rent'
        _outstanding.push payment
      else if payment.status == 'Late' and payment.payment_type == 'Rent'
        _outstanding.push payment
      else if payment.status == 'Paid' and payment.payment_type == 'Rent'
        _received.push payment
      else
        _payments.push payment
   PaymentsStore.emitChange()
   break
  when actions.DESTROYED_PAYMENT
   PaymentsStore.addToFeed payment
   PaymentsStore.emitChange()
   break
 true

module.exports = PaymentsStore