SelectInput = require('./select_input.js.coffee')

EditSelect = React.createClass
	displayName: 'EditSelect'
	getInitialState: ->
		editable: false

	_edit:->
		@setState
			editable: !@state.editable

	_update_status: (val) ->
		up = {}
		up[@props.currentkey] = val
		@props.change_val up

	render: ->
		select = if @state.editable
			sizes = {small: 6, medium: 6, large: 6}
			<SelectInput options={@props.dataset} sizes={sizes} label='Post type' send={@_update_status} current={@props.currentvalue}/>
		else
			<div onClick={@_edit}>
				{@props.currentkey}: {@props.currentvalue}
			</div>
		<div>
			{select}
		</div>
module.exports = EditSelect
