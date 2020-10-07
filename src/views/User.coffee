import Backbone from 'backbone'
import _ from 'underscore'
import $ from 'jquery'

export default Backbone.View.extend(
  tagName:  "li"

  template: _.template $('#trace-template').html()

  events: {
    "click .toggle"   : "toggleDone"
    "dblclick .view"  : "edit"
    "click a.destroy" : "clear"
    "keypress .edit"  : "updateOnEnter"
    "blur .edit"      : "close"
  }

  initialize: -> 
    @listenTo @model, 'change', @render
    @listenTo @model, 'destroy', @remove

  render: ->
    @$el.html @template @model.toJSON()
    @$el.toggleClass 'done', @model.get 'done'
    @input = @$('.edit')
    return @

  toggleDone: ->
    @model.toggle()

  edit: -> 
    @$el.addClass "editing"
    @input.focus()

  close: ->
    value = @input.val()
    if not value
      @clear()
    else
      @model.save title: value
      @$el.removeClass "editing"

  updateOnEnter: (e) ->
    if e.keyCode is 13
      @close()

  clear: ->
      @model.destroy()
)