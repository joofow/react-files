assign = require('object-assign')
Promise = require('es6-promise').Promise

_callbacks = []
_promises = []

_addPromise = (callback, payload) ->
  _promises.push new Promise (resolve, reject) ->
    if callback(payload)
      resolve(payload)
    else
      reject new Error 'Dispatcher callback unsuccessful'

_clearPromises = ->
  _promises = []

Dispatcher = ->
Dispatcher.prototype = assign {}, Dispatcher.prototype,
  register: (callback) ->
    _callbacks.push(callback)
    _callbacks.length - 1
  dispatch: (payload) ->
    _callbacks.forEach (callback) ->
      _addPromise callback, payload
    Promise.all(_promises).then(_clearPromises)
  waitFor: (promiseIndexes, callback) ->
      selectedPromises = promiseIndexes.map index ->
        _promises[index]
      Promise.all(selectedPromises).then(callback)
      
module.exports = Dispatcher 
