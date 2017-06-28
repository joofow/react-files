FloorDrawCard = require('../utilities/floor_draw_card.js.coffee')

ApartmentOverview = React.createClass
	displayName: 'ApartmentOverview'
	getIntialState: ->
		apt_enum: 'Alphabet'

	_on_change: (e) ->
		@props.change_apt(e)

	render: ->
		apt_per_fl = parseFloat(parseInt(@props.data.units) / parseInt(@props.data.floors))
		apt_odd = Math.ceil(apt_per_fl)
		apt_even = Math.floor(apt_per_fl)
		apt_enum = 'Alphabet'
		building = []
		$floor = {}
		is_even = (num, even, odd) ->
			apt = if (num % 2 == 0)
				even
			else
				odd
		remainder = (i,units) ->
		 current = is_even(i,apt_even,apt_odd)
		 val = 0
		 for k, v of $floor
		 	val = val + v
		 rem = units - val
		 if rem < current 
		  current = rem
		 current
		if @props.data.floors? && @props.data.floors.length > 0
			($floor[floor] = remainder(floor,@props.data.units)) for floor in [1..parseInt(@props.data.floors)]
			building.push(<FloorDrawCard apt_enum={apt_enum} change_apt={@_on_change} apts={$floor[floor]} floor={floor} />) for floor in [1..parseInt(@props.data.floors)]
		<div className={@props.visible}>
			<div className="small-5 columns">
				<div className='row'>
					{
						if building?
							building
					}
				</div>
			</div>
		</div>

module.exports = ApartmentOverview