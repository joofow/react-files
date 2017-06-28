PostActionButtons = React.createClass
	displayName: 'PostActionButtons'

	_move: ->
		@props.edit()
	_archive: ->
		@props.archive(if @props.status then false else true)
	_respond: ->
		@props.respond()
	render: ->
		<ul className={'post-actions no-bullet'}>
			<li onClick={@_respond}> Respond</li>
			<li className='move' onClick={@_move}> Edit</li>
			<li className='archive' onClick={@_archive}> {if @props.status then 'Make current' else 'Archive'}</li>
		</ul>


module.exports = PostActionButtons