AlertBox = React.createClass
	displayName: "AlertBox"

	getInitialState: ->
		elapsed: 0
		t_set: false

	componentWillReceiveProps: (nextProps) ->
		if nextProps.data.time > Date.now()
			@setState
				elapsed: 5000
				t_set: true

	componentWillUpdate: (nextProps, nextState) ->
		if (nextState.elapsed > 0 || @state.elapsed > 0) && !@state.t_set 
			@timer = setInterval(@tick, 50)

	componentWillUnmount: ->
		clearInterval(@timer)

	_closeAlert: ->
		@setState
			elapsed: 0
			t_set: false

	tick: ->
		e = @state.elapsed - 50
		if e <= 0
			clearInterval(@timer)
		@setState
			elapsed: if e < 0 then 0 else e
			t_set: if e <= 0 then false else true

	render: ->
		hidden = if @state.elapsed > 0 then '' else 'hide'
		<div data-alert className={"alert-box success radius " + hidden}>
			{ @props.data.message }
			<a href="#" className="close" onClick={ @_closeAlert }>&times;</a>
		</div>

module.exports = AlertBox