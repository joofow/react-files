BuildingFeedCard = require('./building_feed_card.js.coffee')

BuildingFeed = React.createClass
	displayname: 'BuildingFeed'
	
	render: ->
		cards = ((<BuildingFeedCard data={building} key={'building_card_' + building.id} />) for building in @props.feed)
		<section>
			<div>
				{ 
					if cards.length > 0
						"this is def happening"
					else
						"Please Wait While We Load Your Buidlings"
				}
			</div>
		</section>

module.exports = BuildingFeed