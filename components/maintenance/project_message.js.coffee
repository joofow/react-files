ContentEditable = require('../utilities/content_editable.js.coffee')
SubmitButton = require('../form_elements/submit_button.js.coffee')

ProjectMessage = React.createClass
	displayName: 'ProjectMessage'
	
	getInitialState: ->
		html: ''

	componentWillReceiveProps: (nextProps) ->
		if nextProps.value == null
			@setState
				html: ''
 
 changeHandler: (e) ->
 	@setState
   html: e.target.value
	
	_submit_upstream: ->
		@props.submit_message_text @state.html

	render: ->
		sizes = {small: 9, medium: 9, large: 9}
		<div className={'small-8 small-offset-2 columns ' + @props.visible }>
			<ContentEditable html={@state.html} onChange={@changeHandler} className='content-editable' />
			<SubmitButton offset='7' text='Apply' next={@_submit_upstream} classes='row' />
		</div>

module.exports = ProjectMessage