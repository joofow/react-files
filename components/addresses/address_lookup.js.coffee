TextInput = require('../form_elements/text_input.js.coffee')
FormCard = require('../form_elements/form_card.js.coffee')
RegistrationViewActions = require('../../actions/registration_view_actions.js.coffee')
SubmitButton = require('../form_elements/submit_button.js.coffee')
ErrorCard = require('../form_elements/error_card.js.coffee')
AddressLookup = React.createClass
	displayName: 'AddressLookup'

	getInitialState: ->
		building_no: false
		street_1: false
		zip: false

	_form_submit: ->
		new_state = {}
		check = false
		for obj of @refs
			ref = @refs[obj]
			inv = if ref.props.validate && (ref.props.validate.min_length && ref.props.validate.min_length > ref.state.value.length)
				true
			else if ref.props.validate && (ref.props.validate.max_length && ref.props.validate.max_length < ref.state.value.length)
				true
			else
				false
			check = if inv || check then true else false
			new_state[obj] = inv
		if check
			@setState new_state
		else
			RegistrationViewActions.findZip { zip: @refs.zip.state.value, address_line_1: @refs.street_1.state.value, building_no: @refs.building_no.state.value }

	render: ->
		sizes = {small: 6, medium: 6, large: 6}
		<div className={"row address-section" + @props.visible}>
			<div className="small-8 columns">
				<FormCard>
					<TextInput total='12' label="Building No" sizes={sizes} classes='row' validate={{min_length: 1}}>
						<ErrorCard text='Building No needs to be longer than 1 character' show={@state.building_no}/>
					</TextInput>
					<TextInput total='12' label="Street Name" sizes={sizes} classes='row' validate={{min_length: 3}}>
						<ErrorCard text='Street Name needs to be longer than 3 characters' show={@state.street_1}/>
					</TextInput>
					<TextInput total='12' label="Zip Code" sizes={sizes} classes='row' validate={{min_length: 5, max_length: 5}}>
						<ErrorCard text='Zipcode needs to be 5 characters' show={@state.zip}/>
					</TextInput>
					<SubmitButton offset='7' text='Next' next={@_form_submit} classes='row' />
				</FormCard>
			</div>
		</div>

module.exports = AddressLookup