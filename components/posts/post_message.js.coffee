ContentEditable = require('../utilities/content_editable.js.coffee')
SubmitButton = require('../form_elements/submit_button.js.coffee')

PostMessage = React.createClass
	displayName: 'PostMessage'

	getInitialState: ->
		html: ''

	componentWillReceiveProps: (nextProps) ->
		if nextProps.value == null
			@setState
				html: ''
 
 changeHandler: (e) ->
		@props.submit_message_text e.target.value
 	@setState
   html: e.target.value
	
	render: ->
		sizes = {small: 9, medium: 9, large: 9}
		<div className={'post-element small-8 small-offset-2 columns ' + @props.visible }>
			<h2>Post Details:</h2>
			<div className='small-2 columns'>
				<label className='right inline'>Message</label>
			</div>
			<div className='small-10 columns'>
				<ContentEditable html={@state.html} onChange={@changeHandler} className='content-editable' />
			</div>
		</div>

module.exports = PostMessage