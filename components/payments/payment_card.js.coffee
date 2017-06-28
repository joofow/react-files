# @cjsx React.DOM  
PaymentRequestCard =  require('./payment_request_card.js.coffee')

PaymentCard = React.createClass
  displayName: 'PaymentCard'

  componentDidMount: ->

  createMarkup: (value) ->
    {__html: value}

  render: ->
    html = "<div>" + @props.data.type.description + "</div>"
    <div className='payment-card'>
       <div className="payment-amount">{(if @props.me then "You" else @props.name) + " sent " + (if @props.me then @props.names.slice(0, - 1) else "you") +  " a payment" + (if @props.data.type.payment_type == 'request' then " request for " else " of ") + "$" + @props.data.type.amount}</div>
        { 
          if @props.data.type.payment_type == 'request'
            <PaymentRequestCard data={@props.data} /> 
        }
       <div className="payment-text" dangerouslySetInnerHTML={@createMarkup(html)} />
    </div>

module.exports = PaymentCard