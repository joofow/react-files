# @cjsx React.DOM
MessageCard = React.createClass
  displayName: 'MessageCard'
  componentDidMount: ->

  render: ->
  	<div className='row message-line'>
  			<div className='small-2 columns text-right'>
  				<span className='person-box'>{@props.name.first_name}</span>
  				</div>
      <div className='small-10 columns'>
  		  	<span className='message message-mine'>{if @props.data.body then (@props.data.body.charAt(0).toUpperCase() + @props.data.body.slice(1)) else "Oops, no message"}</span>
      </div>
    </div>
    
module.exports = MessageCard