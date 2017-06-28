ContentEditable = require('../utilities/content_editable.js.coffee')

EditText = React.createClass
	
	displayName: 'EditText' 
 
 getInitialState: ->
 	html: @props.currentvalue
 	editable: false
 
 changeHandler: (e) ->
		up = {}
		up[@props.currentkey] = e.target.value
		@props.change_val up 	
		@setState
   html: e.target.value

 _make_editable: ->
 	@setState
 		editable: !@state.editable

	render: ->
		content = if @state.editable
			<div>{@props.currentkey}:
				<ContentEditable ref="message" html={@state.html} onChange={@changeHandler} className='content-editable' />
			</div>
		else
			<div onClick={@_make_editable}> { @state.html }</div>
		<div>
			{ content }
		</div>

module.exports = EditText