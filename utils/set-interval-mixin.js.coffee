SetIntervalMixin =
 componentWillMount: ->
  @intervals = []
   
 setInterval: (fn, ms) ->
  @intervals.push(setInterval(fn, ms))

 componentWillUnmount: ->
  @intervals.forEach(clearInterval)

module.exports = SetIntervalMixin
