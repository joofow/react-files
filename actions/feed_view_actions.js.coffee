AppDispatcher = require('../dispatcher/appdispatcher.js.coffee')
AppConstants = require('../constants/appConstants.js.coffee')
WebAPIUtils = require('../utils/webAPIutils.js.coffee')

ActionTypes = AppConstants.ActionTypes

module.exports = 
  getInitialFeed: ->
    AppDispatcher.handleViewAction
      type: ActionTypes.GETTING_FEED
    WebAPIUtils.getPeople()
				WebAPIUtils.getConversations()
		filterView: (types) ->
			 AppDispatcher.handleViewAction
      type: ActionTypes.FILTER_FEED
      data: types
