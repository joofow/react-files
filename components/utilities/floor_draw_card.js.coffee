ApartmentSketchCard = require('../apartments/apartment_sketch_card.js.coffee')

FloorDrawCard = React.createClass
	displayName: 'FloorDrawCard'

	_on_change: (e) ->
		@props.change_apt(e)

	render: ->
		apts = []
		if @props.apts > 0
			apts.push(<ApartmentSketchCard number={apt} change_apt={@_on_change} floor={@props.floor} />) for apt in [1..parseInt(@props.apts)]
		<div className='row sketch-row'>
			<div className="sketch-floor">{"Floor "+ @props.floor}</div>
			{ apts }
		</div>

module.exports = FloorDrawCard