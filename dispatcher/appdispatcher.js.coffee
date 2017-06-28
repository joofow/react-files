Dispatcher = require('flux').Dispatcher
assign = require('object-assign')
appConstants = require('../constants/appConstants.js.coffee')
PayloadSources = appConstants.PayloadSources

AppDispatcher = assign new Dispatcher,
 handleViewAction: (action) ->
  unless typeof action.type == 'undefined'
 	 @dispatch
    source: PayloadSources.VIEW_ACTION,
    action: action
 handleServerAction: (action) ->
  unless typeof action.type == 'undefined'
   @dispatch
	   source: PayloadSources.SERVER_ACTION,
	   action: action
      
module.exports = AppDispatcher