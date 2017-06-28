AppDispatcher = require('../dispatcher/appdispatcher.js.coffee')
EventEmitter = require('events').EventEmitter
appConstants = require('../constants/appConstants.js.coffee')
assign = require('object-assign')

actions = appConstants.ActionTypes

CHANGE_EVENT = 'change'

_transactions = []

TransactionsStore = assign {}, EventEmitter.prototype,
	
	getTransactions: ->
		_transactions
	getTransaction: (i) ->
		_transaction[i]
	emitChange: ->
		@emit(CHANGE_EVENT)
	addChangeListener: (callback) ->
		@on CHANGE_EVENT, callback
	removeChangeListener: (callback) ->
  @removeListener CHANGE_EVENT, callback

TransactionsStore.dispatchToken = AppDispatcher.register (payload) ->
  action = payload.action
  switch action.type
  	when actions.RECEIVED_NEW_TRANSACTION
  		TransactionsStore.emitChange()
  		break
  	when actions.RECEIVED_TRANSACTIONS
  		TransactionsStore.emitChange()
  		break
  	when actions.DESTROYED_TRANSACTION
  		TransactionsStore.emitChange()
  		break
  true

module.exports = TransactionsStore