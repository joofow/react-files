

DirectoryCard = React.createClass
	displayName: 'DirectoryCard'

	render: ->
		<div className='d-card row panel'>
			<div className='small-4 columns directory-name'>
				{@props.data.name.replace('Apt.','').replace('Suite ','')}
			</div>
			<div className='small-8 columns'>
				<div className='row'><div className='small-12 columns'>{@props.data.p_count} Residents</div></div>
				<div className='row'><div className='small-12 columns directory-smaller'>{parseInt(@props.data.bedrooms) + if @props.data.bedrooms == 1 then ' bed' else ' beds'}, {parseInt(@props.data.bathrooms) +  if @props.data.bathrooms == 1 then ' bath' else ' baths'}</div></div>
			</div>
		</div>

module.exports = DirectoryCard