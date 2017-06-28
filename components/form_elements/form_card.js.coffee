
FormCard = React.createClass
	displayName: "FormCard"
	render: ->
		<form onSubmit={@props.action}>
			{@props.children}
		</form>

module.exports = FormCard