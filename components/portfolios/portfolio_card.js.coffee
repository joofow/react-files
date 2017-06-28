SectionCard = require('../utilities/section_card.js.coffee')
ApartmentIcon = require('../apartments/apartment_icon.js.coffee')
ApartmentInfo = require('../apartments/apartment_info.js.coffee')

PortfolioCard = React.createClass
	displayName: "PortfolioCard"

	render: ->
		<SectionCard>
			<ApartmentIcon data={@props.data} />
			<ApartmentInfo data={@props.data} />
		</SectionCard>

module.exports = PortfolioCard