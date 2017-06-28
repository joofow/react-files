DirectoryCard = require('./directory_card.js.coffee')

DirectorySection = React.createClass

	displayName: 'DirectorySection'

	render: ->
		cards = @props.directory.map (d) ->
			<DirectoryCard data={d} key={'directory' + d.id}/>
		<section>
			<div className='d-header'>
				DIRECTORY
			</div>
			{cards}
		</section>

module.exports = DirectorySection