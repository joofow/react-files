SelectBox = require('../utilities/select_box.js.coffee')

PostChooseAudience = React.createClass
	displayName: 'PostChooseAudience'
	getInitialState: ->
		options: []
	componentWillReceiveProps: (nextProps) ->
		if nextProps.data && nextProps.data.audience_type && nextProps.data.audience_type.length > 0
			@setState
				options: switch @props.data.audience_type
					when 'person'
						@props.people
					when 'apartment','building'
						@props.buildings
					else
						[]
	render: ->
		options = if @props.step == 3
			@props.apartments
		else
			@state.options
		text = if @props.step == 2
			"Choose building:"
		else if @props.step == 3
			"Choose apartment:"
		else
			""
		lookup = if @props.data && @props.data.audience_type == 'person'
			'set_nickname'
		else if @props.data && @props.step == 2
			'address_line_1'
		else if @props.data && @props.step == 3
			'name'
		<div className={'small-8 small-offset-2 columns ' + @props.visible }>
			<h2>{text}</h2>
			<SelectBox data={options} click={@props.idChoosen} visibility={true} lookup={lookup} element_classes='new-button' classes={(if @props.step == 2 then 'small-block-grid-2' else 'small-block-grid-6') + ' post-button-group'}/>
		</div>

module.exports = PostChooseAudience