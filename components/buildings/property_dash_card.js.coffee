PropertyDashCard = React.createClass
	displayName: 'DashCard'

	_go_to_area: ->
		@props.change_in_area @props.area

	render: ->
		logo = @props.logo
		notes = @props.data.map (note) ->
			<li key={logo + note.id}>{note}</li>
		<div className={'ll-dash-p'}>
			<div className={'ll-dash-p-header title-' + @props.logo + '-logo-g'}></div>
			<div className='ll-dash-p-body'>
				<ul className='no-bullet'>
					{ notes }
				</ul>
			</div>
			<div className='ll-dash-p-footer' onClick={@_go_to_area}>See more</div>
		</div>

module.exports = PropertyDashCard