SearchBox = require('../utilities/search_box.js.coffee')

BuildingSearchSection = React.createClass
	displayName: 'BuildingSearchSection'

	render: -> 
		<div>
			<SearchBox />
		</div>

module.exports = BuildingSearchSection