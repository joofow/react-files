
ProjectChooseAudienceType = React.createClass
	displayName: 'ProjectChooseAudienceType'
	_sendType: (e) ->
		@props.typeChoosen e

	render: ->
		<div className={'small-8 small-offset-2 columns ' + @props.visible }>
			<ul className='button-group even-5'>
				Send to: 
				<li onClick={@_sendType.bind(@,'person')}><a href="#" className='button'>Person</a></li>
				<li onClick={@_sendType.bind(@,'apartment')}}><a href="#" className='button'>Apartment</a></li>
				<li onClick={@_sendType.bind(@,'building')}}><a href="#" className='button'>Building</a></li>
				<li onClick={@_sendType.bind(@,'portfolio')}}><a href="#" className='button'>Portfolio</a></li>
			</ul>
		</div>

module.exports = ProjectChooseAudienceType