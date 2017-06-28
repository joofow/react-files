BuildingCard = React.createClass
	displayName: 'BuildingCard'

	_nowActive: ->
		@props.click @props.data.id

	render: ->
		<div className='row panel' onClick={@_nowActive}>
			<div className='small-12 columns empty-building-card'>
					<h4>{@props.data.address_line_1 }</h4>
			</div>
		</div>

module.exports = BuildingCard