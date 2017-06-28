PostChooseAudienceType = React.createClass
	displayName: 'PostChooseAudienceType'

	_sendType: (e) ->
		@props.typeChoosen e

	render: ->
		<div className={'small-8 small-offset-2 columns ' + @props.visible }>
			<h2> Choose Post Audience:</h2>
			<ul className='small-block-grid-2 post-button-group text-center'>
				<li onClick={@_sendType.bind(@,'person')}><div className='new-button'>Person</div></li>
				<li onClick={@_sendType.bind(@,'apartment')}><div className='new-button'>Apartment</div></li>
				<li onClick={@_sendType.bind(@,'building')}><div className='new-button'>Building</div></li>
				<li onClick={@_sendType.bind(@,'portfolio')}><div className='new-button'>Portfolio</div></li>
			</ul>
		</div>

module.exports = PostChooseAudienceType