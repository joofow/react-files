ImageSquare = React.createClass
	displayName: "ImageSquare"
	render:->
	 <div className="square-box">
	 	{ @props.children }
	 </div>

module.exports = ImageSquare