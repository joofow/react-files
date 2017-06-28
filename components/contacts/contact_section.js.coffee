FormCard = require('../form_elements/form_card.js.coffee')
TextInput = require('../form_elements/text_input.js.coffee')
SelectInput = require('../form_elements/select_input.js.coffee')
SectionCard = require('../utilities/section_card.js.coffee')
ContactActions = require('../../actions/contact_view_actions.js.coffee')
ContactSection = React.createClass
	displayName: "ContactSection"

	getInitialState: ->
		sent: false

	_formSubmit: (e) ->
		e.preventDefault()
		data = 
			interest_from: @refs.type.state.value
			name: @refs.name.state.value
			phone: @refs.phone.state.value
			email: @refs.email.state.value
			comment: @refs.comment.state.value
		contacts =
			contacts: data
		ContactActions.postContact contacts
		@refs.name.state.value = ''
		@refs.phone.state.value = ''
		@refs.email.state.value = ''
		@refs.comment.state.value = ''
		@setState
			sent: true

	render: ->
		options = [{value: "landlord", name: "Landlord"},{value: "tenant", name: "Tenant"},{value: "investor", name: "Investor"}]
		sizes = {small: 6, medium: 4, large: 4}
		<SectionCard classes="">
			<FormCard action={@_formSubmit}>
				<div data-alert className={(if @state.sent then '' else 'hide ') + "alert-box success radius small-centered small-6 columns"} tabIndex="0" aria-live="assertive" role="alertdialog">
					Thanks for contacting us! We will reach out to you as soon as possible.
					<button tabIndex="0" className="close" aria-label="Close Alert">&times;</button>
				</div>
				<div className="row">
					<div className={"small-8 columns"}>	
						<SelectInput sizes={sizes} label="I am a" options={options} ref="type" classes='row'/>
					</div>
				</div>
				<div className="row">
					<div className={"small-8 columns"}>	
						<TextInput sizes={sizes} label="Name" ref="name" classes='row'/>
					</div>
				</div>
				<div className="row">
					<div className={"small-8 columns"}>
						<TextInput sizes={sizes} label="Phone Number" ref="phone" classes='row'/>
					</div>
				</div>
				<div className="row">
					<div className={"small-8 columns"}>
						<TextInput sizes={sizes} label="Email" ref="email" classes='row'/>
					</div>
				</div>
				<div className="row">
					<div className={"small-8 columns"}>
						<TextInput sizes={sizes} label="Comment" ref="comment" classes='row'/>
					</div>
				</div>
				<div className="small-8 columns">
					<input type="submit" className="right" />
				</div>
			</FormCard>
		</SectionCard>

module.exports = ContactSection