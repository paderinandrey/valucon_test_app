angular.module('feedbacks').factory 'feedbacks', [
  '$http'
  ($http) ->
    o = feedbacks: []
    
    o.getAll = ->
      $http.get('/feedbacks.json').success((data) ->
        angular.copy data, o.feedbacks
        return
      ).error (data, status, headers, config) ->
          alert 'There was a problem: ' + status
          return 
       
    o.create = (feedback) ->
      $http.post('/feedbacks.json', feedback).success (data) ->
        o.feedbacks.push data
        return 
        
    o
  ]
