AppDispatcher = require('../dispatcher/appdispatcher.js.coffee')
AppConstants = require('../constants/appConstants.js.coffee')
WebAPIUtils = require('../utils/webAPIutils.js.coffee')

ActionTypes = AppConstants.ActionTypes

module.exports = 

	connect_client: ->
		AppDispatcher.handleViewAction
			type: ActionTypes.CONNECT_CLIENT
		WebAPIUtils.connect_faye_client(uuid)