SubmitButton = React.createClass
	displayName: "SubmitButton"

	_nextPage: ->
		@props.next()

	render: ->
		<div className={@props.classes}>
			<div className={"small-offset-" + @props.offset + " small-" + (12-parseInt(@props.offset)) + " columns"}>
				<a href='#' onClick={@_nextPage} className="button round right">{@props.text}</a>
			</div>
		</div>

module.exports = SubmitButton