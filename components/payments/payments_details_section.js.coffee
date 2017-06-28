SectionCard = require('../utilities/section_card.js.coffee')
PaymentFeedCard = require('./payment_feed_card.js.coffee')

PaymentsDetailsSection = React.createClass
	displayName: 'PaymentsDetailsSection'
	render: ->
		cards = ((<PaymentFeedCard data={payment} key={'payment_card_' + payment.id} person={@props.people[payment.person_id]}/>) for payment in @props.data)
		<SectionCard>
			<div className='medium-12 columns'>
				{ 
					if cards.length > 0
						{ cards }
					else
						"Please Wait While We Load Your Payments"
				}
			</div>
		</SectionCard>

module.exports = PaymentsDetailsSection