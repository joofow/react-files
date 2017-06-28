SmallPhoto = React.createClass
	displayName: "SmallPhoto"

	render: ->
	 <div>
	 	<img src={@props.data.photo_url || "" } />
	 </div>

module.exports = SmallPhoto