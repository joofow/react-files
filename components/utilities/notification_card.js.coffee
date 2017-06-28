NotificationCard = React.createClass
	displayName: 'NotificationCard'

	render: ->
		<div>
			{@props.data} Noticed
		</div>

module.exports = NotificationCard