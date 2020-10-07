import Backbone from 'backbone'
import UserList from '../collections/UserList.coffee'
import UserView from './User.coffee'
import Inputmask from 'inputmask'
import _ from 'underscore'
import $ from 'jquery'

App = Backbone.View.extend(
  el: document.getElementById 'root'

  events:
    'click #new-user':  'create',
    'click #toggle-all': 'toggleAllComplete'
    'focus input': 'focus'

  initialize: ->
    @name = document.getElementById 'name'
    @phone = document.getElementById 'phone'

    @allCheckbox = document.getElementById 'toggle-all'

    @listenTo UserList, 'add', @addOne
    @listenTo UserList, 'reset', @addAll
    @listenTo UserList, 'all', @render

    @main = document.getElementById 'main'

    UserList.fetch()

  render: ->
    done = UserList.done().length
    remaining = UserList.remaining().length

    @allCheckbox.checked = not remaining

    Inputmask().mask document.querySelectorAll 'input'

  addOne: (User) ->
    view = new UserView model: User
    document.querySelector('#table tbody').appendChild view.render().el

  addAll: ->
    UserList.each @addOne, @

  create: (e) ->
    unless @name.value
      @name.classList.add 'require'

    unless @phone.value
      @phone.classList.add 'require'
      
    if @name.value and @phone.value
      UserList.create name: @name.value, phone: @phone.value
      @name.value = ''
      @phone.value = ''

  focus: (e) ->
    e.target.classList.remove 'require'

  toggleAllComplete: ->
    checked = @allCheckbox.checked
    UserList.each (User) -> User.save 'checked': checked
)

export default new App