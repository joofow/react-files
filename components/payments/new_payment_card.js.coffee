PersonList = require('../people/person_list.js.coffee')
ContentEditable = require('../utilities/content_editable.js.coffee')
PaymentActionCreators = require('../../actions/payments_view_actions.js.coffee')
AddPeopleCard = require('../people/add_people_card.js.coffee')

NewPaymentCard = React.createClass
 displayName: "NewPaymentCard"
 
 getInitialState: ->
  recipient: (if @props.data.assigned_person_id == Array then @props.data.assigned_person_id else @props.data.assigned_person_id.toString().split(","))
  text: ''
  end_date: ''
  pay: true
  request: false
 
 _handleOnSubmit: (e) ->
  e.preventDefault()
  # the value of the message box input
  data =
   description: @refs.description.lastHtml
   ids: @state.recipient
   amount: @refs.amount.getDOMNode().value
   date: @refs.date.getDOMNode().value
   request: if @state.request then 'request' else 'pay'
  @setState 
   html: ''
  PaymentActionCreators.createPayment data
  @props.close()

 addAdditionalPeople: (ids) ->
  idsNew = @state.recipient
  if idsNew.indexOf(ids) > -1 then '' else idsNew.push(ids)
  @setState
   recipient: idsNew

 changeHandler: (e) ->
  @setState
   html: e.target.value

 onRadioChange: ->
  @setState
   pay: @state.request
   request: !@state.request
   html: @state.html

 render: ->
  visibility = if @props.data.visible
    ''
   else
    'hide '
  <div className={visibility + "new-payment"}>
   <form onSubmit={@_handleOnSubmit}>
    <div className="people-for">
     {
      if @state.recipient
       <PersonList keys={@state.recipient} />
      else
       ""
     }
     <AddPeopleCard data={@props.data.assigned_person_id} update={@addAdditionalPeople} />
    </div>
    <div className="row">
     <div className="small-6 columns">
      <ContentEditable ref="description" html={@state.html} onChange={@changeHandler} id="payment-editable" />
     </div>
     <div className="small-3 columns">
      <input ref="amount" type="text" />
     </div>
     <div className="small-3 columns">
      <input ref="date" type="date" />
     </div>
    </div>
    <div className="row">
     <div className="small-3 columns">
      <input ref="pay" type="radio" checked={@state.pay} onChange={@onRadioChange}>PAY</input>
     </div>
     <div className="small-3 columns">
      <input ref="request" type="radio" checked={@state.request } onChange={@onRadioChange}>REQUEST</input>
     </div>
     <input type="submit" name="submit" />
    </div>
   </form>
  </div>

module.exports = NewPaymentCard