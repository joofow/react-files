ContentEditable = React.createClass

  shouldComponentUpdate: (nextProps) ->
    nextProps.html != @getDOMNode().innerHTML
  componentDidUpdate: ->
    if @props.html != @getDOMNode().innerHTML
      @getDOMNode().innerHTML = @props.html
  removeText: ->
    html = @getDOMNode().innerHTML
    if html == '<i>Type here</i>' || html == "<i>add person</i>"
        html = ''
    @getDOMNode().innerHTML = html
  emitChange: (evt) ->
    html = @getDOMNode().innerHTML
    if @props.onChange and html != @lastHtml
      evt.target = value: html
      @props.onChange evt
    @lastHtml = html   
  render: ->
    <div
      {...@props}
      onInput={@emitChange} 
      onBlur={@emitChange}
      onFocus={@removeText}
      contentEditable="true"
      dangerouslySetInnerHTML={{__html: @props.html}}>
    </div>
module.exports = ContentEditable