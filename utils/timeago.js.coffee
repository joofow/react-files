SetIntervalMixin = require("./set-interval-mixin.js.coffee")
moment = require("moment")

TimeAgo = React.createClass
 mixins: [SetIntervalMixin]
 
 componentDidMount: ->
  interval = @props.refreshMillis || 60000
  @setInterval(@forceUpdate.bind(@), interval)
 render: ->
  <span className="timeago right">{moment(@props.time).fromNow().replace(' ago','')}</span>

module.exports = TimeAgo;
