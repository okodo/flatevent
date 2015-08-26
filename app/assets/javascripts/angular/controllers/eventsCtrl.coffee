angular.module('flatEvent').controller('EventsCtrl', [ 
  '$scope'
  'events'
  'event'
  ($scope, events, event) ->
    $scope.event = event
    $scope.addComment = ->
      events
        .addComment(event.id, { body: $scope.body })
        .success((comment) ->
          $scope.event.comments.push(comment)
        )
      $scope.body = ''
])
