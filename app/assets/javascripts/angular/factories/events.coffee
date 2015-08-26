angular.module('flatEvent').factory 'events', [
  '$http'
  'Auth'
  ($http, Auth) ->
    o = events: []

    o.getAll = (all) ->
      $http({url: '/events.json', method: "GET", params: all}).success (data) ->
        _.each data, (n) ->
          n['startsAt'] = new Date(n['startsAt'])
          n['endsAt'] = n['startsAt']
          n['editable'] = false if Auth._currentUser.id != n["user_id"]
          n['deletable'] = false if Auth._currentUser.id != n["user_id"]
          return
        angular.copy data, o.events
        return

    o.update = (event) ->
      $http.put('/events/' + event.id + '.json', event).success (data) ->
        idx = _.findIndex(o.events, (el) -> el.id == data.id);
        o.events.pop idx
        o.events.push data
        return

    o.destroy = (id) ->
      $http.delete('/events/' + id + '.json').success (data) ->
        return

    o.create = (event) ->
      $http.post('/events.json', event).success (data) ->
        o.events.push data
        return

    o.get = (id) ->
      $http.get('/events/' + id + '.json').then (result) ->
        result.data

    o.addComment = (id, comment) ->
      $http.post '/events/' + id + '/comments.json', comment

    o
]
