SectionCard = React.createClass
	displayName: "SectionCard"

	render: ->
		<section className={ @props.classes + " section-card" }>
			{ @props.children }
		</section>

module.exports = SectionCard