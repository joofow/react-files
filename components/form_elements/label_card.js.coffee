LabelCard = React.createClass
	displayName: "LabelCard"
	render: ->
		<label className="right inline">{@props.text}</label>
module.exports = LabelCard