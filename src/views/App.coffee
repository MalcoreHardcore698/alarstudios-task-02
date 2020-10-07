import Backbone from 'backbone'
import UserList from '../collections/UserList.coffee'
import UserView from './User.coffee'
import _ from 'underscore'
import $ from 'jquery'

App = Backbone.View.extend(
  el: $ "#root"

  statsTemplate: _.template $('#stats-template').html()

  events:
    "keypress #new-User":  "createOnEnter",
    "click #clear-completed": "clearCompleted",
    "click #toggle-all": "toggleAllComplete"

  initialize: ->
    @form = @$ "#new-user"
    @allCheckbox = @$("#toggle-all")[0]

    @listenTo UserList, 'add', @addOne
    @listenTo UserList, 'reset', @addAll
    @listenTo UserList, 'all', @render

    @footer = @$ 'footer'
    @main = $ '#main'

    UserList.fetch()

  render: ->
    done = UserList.done().length
    remaining = UserList.remaining().length

    if (UserList.length)
      @main.show()
      @footer.show()
      @footer.html(@statsTemplate done: done, remaining: remaining)
    else
      @main.hide()
      @footer.hide()

    @allCheckbox.checked = not remaining

  addOne: (User) ->
    view = new UserView model: User
    @$("#table tbody").append view.render().el

  addAll: ->
    UserList.each @addOne, @

  createOnEnter: (e) ->
    if e.keyCode isnt 13
      return
    if not @input.val()
      return

    UserList.create title: @input.val()
    @input.val ''

  clearCompleted: ->
    _.invoke UserList.done(), 'destroy'
    return false

  toggleAllComplete: ->
    done = @allCheckbox.checked
    UserList.each (User) -> User.save 'done': done
)

export default new App