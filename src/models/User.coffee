import Backbone from 'backbone'
import UserList from '../collections/UserList.coffee'

export default Backbone.Model.extend(
  defaults: ->
    name: 'Unknown User'
    phone: '891234567891'
    order: UserList.nextOrder()
    checked: false
    editing: false

  edit: ->
    @save editing: not @get 'editing'

  toggle: ->
    @save checked: not @get 'checked'
)