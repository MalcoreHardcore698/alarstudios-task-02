import Backbone from 'backbone'
import User from '../models/User.coffee'
import 'backbone.localstorage'

UserList = Backbone.Collection.extend(
  model: User
  localStorage: new Backbone.LocalStorage("users-backbone")

  done: ->
    @where checked: true

  remaining: ->
    @where checked: false

  nextOrder: ->
    if not @length
      return 1
    else
      return @last().get 'order' + 1

  comparator: 'order'
)

export default new UserList