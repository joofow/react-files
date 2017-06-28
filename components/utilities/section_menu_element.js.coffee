SectionMenuElement = React.createClass
	displayName: 'SectionMenuElement'

	_change_section: ->
		@props.switch_section @props.name

	render: ->
		<dd onClick={@_change_section} className={if @props.current then 'active-section' else '' }>
			<a>
				<span className="label">{if @props.count? then @props.count else ""}</span>
				{@props.name}
			</a>
		</dd>

module.exports = SectionMenuElement