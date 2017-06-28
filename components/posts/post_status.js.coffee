SelectInput = require('../form_elements/select_input.js.coffee')

PostStatus = React.createClass
	displayName: 'PostStatus'

	_update_status: (data) ->
		@props.update_status data

	render: ->
		options = [{value: "complaint", name: "Complaint"},{value: "delivery", name: "Delivery"},{value: "maintenance", name: "Maintenance"},{value: "information", name: "Information"},{value: "other", name: "Other"}]
		sizes = {small: 10, medium: 10, large: 10}
		<div className={'post-element small-8 small-offset-2 columns ' + @props.visible}>
			<SelectInput options={options} sizes={sizes} label='Post type' send={@_update_status}/>
		</div>

module.exports = PostStatus
