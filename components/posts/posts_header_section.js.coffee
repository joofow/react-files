PostsHeaderSection = React.createClass
	displayName: 'PostsHeaderSection'

	_add_to_list: (e) ->
		e.preventDefault()
		@props.start_page_action()
	
	_open_archive: ->
		@props.archive()
	
	_create_new_post: ->
		@props.open_new_post()

	render:->
		<div className='row'>
			<div className='small-12 columns'>
				<div className='row'>
					<div className='small-5 columns text-center action-panel' onClick={@_create_new_post}>
						Create New Post
					</div>
					<div className='small-5 columns text-center action-panel' onClick={@_open_archive}>
						{ if @props.current then "Current Posts" else "Archived Posts" }
					</div>
				</div>
			</div>
		</div>

module.exports = PostsHeaderSection