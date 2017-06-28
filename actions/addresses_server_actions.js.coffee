appDispatcher = require('../dispatcher/appdispatcher.js.coffee')
appConstants = require('../constants/appConstants.js.coffee')
WebAPIUtils = require('../utils/webAPIutils.js.coffee')

ActionTypes = appConstants.ActionTypes

module.exports =

  receivedAddresses: (data) ->
    appDispatcher.handleViewAction
      type: ActionTypes.RECEIVED_ZIP
      data: data