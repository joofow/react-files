LabelCard = require('./label_card.js.coffee')
TextInput = React.createClass
	displayName: "TextInput"

	getInitialState: ->
		value: if @props.initial_value then @props.initial_value else ''

	_handleChange: (e) ->
		@setState
			value: e.target.value

	componentDidUpdate: (nextProps,nextState) ->
		val = @props.initial_value
		stat = @state.value
		if @props.deliver_to_parent? && nextState.value != stat
			@props.deliver_to_parent()
		else if nextProps.initial_value
			@setState
				value: nextProps.initial_value

	moveCursorToEnd: (el) ->
	 if typeof el.createTextRange != "undefined"
	  el.focus()
	  range = el.createTextRange()
	  range.collapse(false)
	  range.select()

	render: ->
		if @props.sizes
			inputsizes = "small-"+@props.sizes.small.toString()+" medium-"+@props.sizes.medium.toString()+" large-"+@props.sizes.large.toString()+" columns"
			labelsizes = "small-"+(12-@props.sizes.small).toString()+" medium-"+(12-@props.sizes.medium).toString()+" large-"+(12-@props.sizes.large).toString()+" columns"
		<div className={@props.classes}>
			{
				if @props.label
					<div className={labelsizes}>
						<LabelCard text={@props.label} className={@props.labelClass} />
					</div>
			}
			<div className={inputsizes}>
				{ @props.children }
				<input type={@props.input_type || 'text'} onChange={@_handleChange} placeholder={@props.placeholder} value={@state.value} />
			</div>
		</div>

module.exports = TextInput