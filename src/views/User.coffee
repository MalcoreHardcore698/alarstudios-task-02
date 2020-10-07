import Backbone from 'backbone'
import _ from 'underscore'
import $ from 'jquery'

export default Backbone.View.extend(
  tagName: 'tr'

  template: _.template document.getElementById('trace-template').innerHTML

  events: {
    'click .toggle': 'toggleDone'
    'click button.edit': 'edit'
    'click button.apply': 'apply'
    'click button.delete': 'delete'
  }

  initialize: -> 
    @listenTo @model, 'change', @render
    @listenTo @model, 'destroy', @remove

  render: ->
    @$el.html @template @model.toJSON()
    @$el.toggleClass 'done', @model.get 'done'
    @name = @$ '.form-control.name'
    @phone = @$ '.form-control.phone'
    return @

  toggleDone: ->
    @model.toggle()

  edit: ->
    @model.edit()

  apply: ->
    name = @name.val()
    phone = @phone.val()

    unless name
      @name.addClass 'require'
    unless phone
      @phone.addClass 'require'

    if name and phone
      @model.save name: name
      @model.save phone: phone
      @model.edit()

  delete: ->
    @model.destroy()
)