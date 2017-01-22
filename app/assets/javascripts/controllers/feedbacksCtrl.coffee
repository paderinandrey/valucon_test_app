angular.module('feedbacks').controller('FeedbacksCtrl', [
  '$scope'
  '$state'
  'feedbacks'
  ($scope, $state, feedbacks) ->
    $scope.feedbacks = feedbacks.feedbacks

    $scope.showForm = false

    $scope.addFeedback = ->
      if !$scope.email or $scope.email == ''
        return
      feedbacks.create
        email: $scope.email
        text: $scope.text
      $scope.email = ''
      $scope.text = ''
      return
  ])