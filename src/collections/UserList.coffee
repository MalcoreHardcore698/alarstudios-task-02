import Backbone from 'backbone'
import User from '../models/User.coffee'
import 'backbone.localstorage'

UserList = Backbone.Collection.extend(
  model: User

  sync: (method, model) ->
    # fetching data...
    # add data to model
    model.add new User() for i in [0, 1, 2, 3, 4]

  # IS NOT WORK becouse define sync
  localStorage: new Backbone.LocalStorage('users-backbone')

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