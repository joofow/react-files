SubmitButton = require('../form_elements/submit_button.js.coffee')

PostConfirmation = React.createClass
	displayName: 'PostConfirmation'

	shouldComponentUpdate: (nextProps,nextState) ->
		if nextProps.visible != @props.visible
			true
		else
			false

	render: ->
		sizes = {small: 9, medium: 9, large: 9}
		<div className={'small-8 small-offset-2 columns ' + @props.visible }>
				To: {@props.data.audience_type + " " + @props.data.audience_id} <br />
				Note Active: {@props.data.from + " - " + @props.data.to} <br />
				Message: <span dangerouslySetInnerHTML={{__html: @props.data.message}}></span><br /> 
				Acknowledgement: {@props.data.acknowledgement} <br />
				<SubmitButton offset='7' text='Submit' next={@props.confirmed} classes='row' />
		</div>

module.exports = PostConfirmation