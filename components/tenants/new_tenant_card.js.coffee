FormCard = require('../form_elements/form_card.js.coffee')
TextInput = require('../form_elements/text_input.js.coffee')
SubmitButton = require('../form_elements/submit_button.js.coffee')
RegistrationViewActions = require('../../actions/registration_view_actions.js.coffee')

NewTenantCard = React.createClass
	displayName: 'NewTenantCard'

	getInitialState: ->
		visible: @props.showing

	componentWillReceiveProps: (nextProps) ->
		@refs.first_name.state.value = ''
		@refs.last_name.state.value = ''
		@refs.email.state.value = ''
		@refs.phone.state.value = ''
		if nextProps.showing != @props.showing
			@setState
				visible: nextProps.showing

	_form_submit: ->
		data = 
			first_name: @refs.first_name.state.value
			last_name: @refs.last_name.state.value
			email: @refs.email.state.value
			phone: @refs.phone.state.value
		RegistrationViewActions.addNewTenant data

	render: ->
		no_sizes = {small: 6, medium: 6, large: 6}
		large_sizes = {small: 8, medium: 8, large: 8}		
		<div className={if @state.visible then '' else 'hide'}>
			<FormCard>
				<div className="row">
					<div className={"small-5 columns"}>	
						<TextInput input_type='text' label="First Name" sizes={no_sizes} classes="row" labelClasses='right'/>
					</div>
					<div className={"small-5 columns end"}>	
						<TextInput input_type='text' label="Last Name" sizes={no_sizes} classes="row" labelClasses='right'/>
					</div>
				</div>
				<div className="row">
					<div className={"small-10 columns"}>	
						<TextInput input_type='text' label="Email" sizes={large_sizes} classes="row" labelClasses='right'/>
					</div>
				</div>
				<div className="row">					
					<div className={"small-10 columns"}>	
						<TextInput input_type='text' label="Phone No" sizes={large_sizes} classes="row" labelClasses='right'/>
					</div>
				</div>
				<SubmitButton offset='7' text='ADD' next={@_form_submit} classes='row' />
			</FormCard>
		</div>

module.exports = NewTenantCard