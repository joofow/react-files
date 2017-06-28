ErrorCard = React.createClass
	displayName: 'ErrorCard'

	render: ->
		show = if @props.show then '' else 'hide'
		<div className={show + " alert alert-box radius"}>
			{ @props.text }
		</div>

module.exports = ErrorCard