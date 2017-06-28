PaymentsSummarySection = require('../payments/payments_summary_section.js.coffee')
PaymentsDetailsSection = require('../payments/payments_details_section.js.coffee')
PaymentAccountSection = require('../payments/payment_account_section.js.coffee')
PaymentsMenu = require('../payments/payments_menu.js.coffee')
createFragment = require('react-addons-create-fragment')

PaymentsPage = React.createClass
	displayName: 'PaymentsPage'

	getInitialState: ->
		payments: @props.data.payments
		name: 'Dashboard'

	_change_section: (page) ->
		@setState
			name: page
	render: ->
		page = switch @state.name
									when 'Dashboard'
										createFragment one: <PaymentsSummarySection data={@state.payments} people={@props.people} name={@state.name}/>
									when 'Late', 'Received'
										createFragment two: <PaymentsDetailsSection data={@state.payments} people={@props.people}/>
									when 'My Payment Info'
										createFragment three: <PaymentAccountSection person={@props.data.me} />
									when 'Deposit'
										createFragment four: <PaymentsDetailsSection data={@state.payments} people={@props.people}/>
		<div className={@props.visible}>
			<div className='row'>
				<div className='small-12 columns text-center' data-cssid='posts-title-section'>
					Payments
				</div>
			</div>
			<div className='row'>
				<div className="medium-3 columns" data-cssid='payments-left-section'>
					<PaymentsMenu goto={@_change_section} page={@state.page} new_project={@_newProjectClick} move_page={@_change_section} current={@state.name} data={@state.payments} name={@state.name} status={@state.status} move_section={@_change_status} counts={@state}/>
				</div>
				<div className='medium-9 columns end'>
					<div className='row'>
						<div className='medium-12 columns'>
							{page }
						</div>
					</div>
				</div>
			</div>
		</div>

module.exports = PaymentsPage