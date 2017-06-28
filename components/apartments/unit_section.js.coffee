NewUnitCard = require('./new_unit_card.js.coffee')
UnitCard = require('./unit_card.js.coffee')
TextInput = require('../form_elements/text_input.js.coffee')
FormCard = require('../form_elements/form_card.js.coffee')
ContentEditable = require('../utilities/content_editable.js.coffee')
LabelCard = require('../form_elements/label_card.js.coffee')

UnitSection = React.createClass
	displayName: 'UnitSection'
 
 getInitialState: ->
 	html: ''
	
 changeHandler: (e) ->
   @setState
     html: e.target.value
	
	render: ->
		no_sizes = {small: 4, medium: 4, large: 4}		
		date_sizes = {small: 7, medium: 7, large: 7}		
		<div className={@props.visible}>
			<div className='small-12 columns'>
				<FormCard>
					<div className="row">
						<div className={"small-5 columns"}>	
							<TextInput input_type='number' label="Sq Footage" sizes={no_sizes} classes="row" labelClasses='right'/>
						</div>
					</div>
					<div className="row">
						<div className={"small-5 columns"}>	
							<TextInput input_type='number' label="Bedrooms" sizes={no_sizes} classes="row" labelClasses='right' />
						</div>
					</div>
					<div className="row">
						<div className={"small-5 columns"}>	
							<TextInput input_type='number' label="Bathrooms" sizes={no_sizes} classes="row" labelClasses='right'  />
						</div>
						<div className={"small-6 columns end"}>	
							<TextInput input_type='date' label="Lease End" sizes={date_sizes} classes="row" labelClasses='right'  />
						</div>
					</div>
					<div className="row">
						<div className={"small-5 columns"}>	
							<TextInput input_type='number' label="Lease Length" sizes={no_sizes} classes="row" labelClasses='right'  />
						</div>
						<div className={"small-6 columns end"}>	
							<TextInput input_type='date' label="Rent Due" sizes={date_sizes} classes="row" labelClasses='right'  />
						</div>				
					</div>
					<div className="row">
						<div className={"small-5 columns"}>	
							<TextInput input_type='number' label="Monthly Rent" sizes={no_sizes} classes="row" labelClasses='right'  />
						</div>
						<div className={"small-6 columns end"}>	
							<TextInput input_type='date' label="Rent Late" sizes={date_sizes} classes="row" labelClasses='right'  />
						</div>		
					</div>
					<div className="row">
						<div className={"small-3 columns"}>
							<div className='row'>
								<div className={"small-12 columns"}>
									<LabelCard text='Notes' className='right' />
								</div>
							</div>
						</div>
						<div className={"small-7 columns end"}>
      	<ContentEditable html={@state.html} onChange={@changeHandler} className='content-editable' />
      </div>
					</div>
				</FormCard>
			</div>
		</div>

module.exports = UnitSection