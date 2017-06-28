TextInput = require('../form_elements/text_input.js.coffee')
SearchBox = React.createClass
	displayName: 'SearchBox'

	_current_search: ->
		@props.search @refs.searchbox.state.value

	render: ->
		<TextInput placeholder='Search Buildings...' deliver_to_parent={@_current_search} />

module.exports = SearchBox