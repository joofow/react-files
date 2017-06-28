PropertyDashCard = require('../buildings/property_dash_card.js.coffee')

BuildingInformation = React.createClass
	displayName: 'BuildingInformation'

	render: ->
		<section>
			<div className={'row ' + (if @props.data.length == 0 then 'hide' else '')}>
				<ul className='small-block-grid-2'>
				 <li><PropertyDashCard data={@props.data} logo='properties' change_in_area={@props.change_area} /></li>
				 <li><PropertyDashCard data={@props.data} logo='notice'change_in_area={@props.change_area} /></li>
				</ul>
				<ul className='small-block-grid-3'>
				 <li><PropertyDashCard data={@props.data} logo='maintain' change_in_area={@props.change_area} /></li>
				 <li><PropertyDashCard data={@props.data} logo='speaker' change_in_area={@props.change_area} /></li>
				 <li><PropertyDashCard data={@props.data} logo='payment' change_in_area={@props.change_area} /></li>
				</ul>
			</div>
		</section>

module.exports = BuildingInformation