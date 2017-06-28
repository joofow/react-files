LabelCard = require('./label_card.js.coffee')

SelectInput = React.createClass
	displayName: "SelectInput"

	getInitialState: ->
		value: @props.current || @props.options[0].value
		inputsizes: "small-"+@props.sizes.small.toString()+" medium-"+@props.sizes.medium.toString()+" large-"+@props.sizes.large.toString()+" columns"
		labelsizes: "small-"+(12-@props.sizes.small).toString()+" medium-"+(12-@props.sizes.medium).toString()+" large-"+(12-@props.sizes.large).toString()+" columns"

	_handleChange: (e) ->
		if typeof @props.send == 'function'
			@props.send e.target.value
		@setState
			value: e.target.value

	render: ->
		value = @state.value
		options = @props.options.map (option) ->
			<option value={option.value} key={option.value}>{option.name}</option>
		<div className={@props.classes}>
			{
				if @props.label
					<div className={@state.labelsizes}>
						<LabelCard text={@props.label} />
					</div>
			}
			<div className={@state.inputsizes}>
				<select value={value} onChange={@_handleChange}>
					{ options }
		  </select>
		 </div>
		</div>


module.exports = SelectInput