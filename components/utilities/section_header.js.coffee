SectionHeader = React.createClass
	displayName: 'SectionHeader'

	render: ->
		<div className='row section-header'>
			<div className='small-12 columns'>
				<i className='fa fa-times-circle left' onClick={@props.exit}></i>
				<h2 className="text-center">{@props.title}</h2>
			</div>
		</div>

module.exports = SectionHeader