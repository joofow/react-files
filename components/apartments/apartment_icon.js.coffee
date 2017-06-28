SmallPhoto = require('../utilities/small_photo.js.coffee') 
ImageSquare = require('../utilities/image_square.js.coffee')

ApartmentIcon = React.createClass
	displayName: "ApartmentIcon"

	render: ->
		<div className="small-3 columns">
			<ImageSquare>
				<SmallPhoto data={@props.data} />
			</ImageSquare>
		</div>

module.exports = ApartmentIcon