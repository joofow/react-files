SectionCard = require('../utilities/section_card.js.coffee')
PaymentsMainChartSection = require('./payments_main_charts_section.js.coffee')
PaymentsKPISection = require('./payments_kpi_section.js.coffee')
PaymentsSparklinesSection = require('./payments_sparklines_section.js.coffee')

PaymentsSummarySection = React.createClass
	displayName: 'PaymentsSummarySection'
	render: ->
		 sections = []
			if @props.name == 'Dashboard'
				sections.push <PaymentsMainChartSection data={@props.data} />
				sections.push <PaymentsKPISection data={@props.data} />
				sections.push <PaymentsSparklinesSection data={@props.data} />
			<div className='row'>
				<div className='medium-12 columns'>
					<div className='row'>
						<div className='medium-12 columns' data-cssid='payments-main-feed'>
							{ sections }
						</div>
					</div>
				</div>
			</div>

module.exports = PaymentsSummarySection