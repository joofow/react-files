ElementBox = require('./element_box.js.coffee')
ToggleBox = require('./toggle_box.js.coffee')

SelectBox = React.createClass
	displayName: 'SelectBox'

	render: ->
		$props = @props
		if @props.data && @props.data.length > 0
			all_elements = @props.data.map (element) ->
				<ElementBox click={$props.click} data={element} key={element.id} lookup={$props.lookup} classes={$props.element_classes}/>
		<div className="select-box row">
			<ToggleBox visibility={@props.visibility} classes={@props.classes}>
				{ all_elements  || "Loading options..."}
			</ToggleBox>
		</div>

module.exports = SelectBox