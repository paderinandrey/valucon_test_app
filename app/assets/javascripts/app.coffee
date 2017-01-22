feedbacks = angular.module('feedbacks', ['ui.router', 'templates'])

feedbacks.config [
  '$stateProvider'
  '$urlRouterProvider'
  ($stateProvider, $urlRouterProvider) ->
    $stateProvider
    .state 'feedbacks',
      url: '/feedbacks'
      templateUrl: 'feedbacks/_index.html'
      controller: 'FeedbacksCtrl'
      resolve:
        postPromise: ['feedbacks', ((feedbacks) -> feedbacks.getAll())]
  
  
    $urlRouterProvider.otherwise ($injector, $location) ->
      $state = $injector.get('$state')
      $state.go 'feedbacks'
      return      
  ]
