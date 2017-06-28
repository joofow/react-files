ProjectActionButtons = React.createClass
	displayName: 'PostActionButtons'

	_move: ->
		@props.edit()
	_respond: ->
		@props.respond()
	render: ->
		<ul className={'project-actions no-bullet'} ref='post'>
			<li onClick={@props.start_next_action}> {@props.next_action}</li>
			<li className='move' onClick={@_respond}> Respond</li>
			<li className='archive' onClick={@_edit}> Edit </li>
		</ul>


module.exports = ProjectActionButtons