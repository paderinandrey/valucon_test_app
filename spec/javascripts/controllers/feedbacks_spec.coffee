describe 'FeedbacksCtrl', ->
  describe 'Initialization', ->
    scope = null
    controller = null
    beforeEach module('feedbacks')
    beforeEach inject(($controller, $rootScope) ->
      scope = $rootScope.$new()
      controller = $controller('FeedbacksCtrl', $scope: scope)
      return
    )
    it 'defaults to an empty feedback list', ->
      expect(scope.feedbacks).toEqualData []
      return
    return
  describe 'Fetching data', ->
    scope = null
    controller = null
    httpBackend = null
    serverResults = [
      {
        id: 123
        email: 'user1@test.com'
        text: 'MyText'
      }
      {
        id: 456
        email: 'user2@test.com'
        text: 'MyText'
      }
    ]
    beforeEach module('feedbacks')
    beforeEach inject(($controller, $rootScope, $httpBackend) ->
      scope = $rootScope
      httpBackend = $httpBackend
      controller = $controller('FeedbacksCtrl', $scope: scope)
      return
    )
    beforeEach ->
      httpBackend.when('GET', '/feedbacks.json').respond serverResults
      return
    it 'populates the feedback list', ->
      httpBackend.flush()
      expect(scope.feedbacks).toEqualData serverResults
      return
    return
  describe 'Error Handling', ->
    scope = null
    controller = null
    httpBackend = null
    beforeEach module('feedbacks')
    beforeEach inject(($controller, $rootScope, $httpBackend) ->
      scope = $rootScope.$new()
      httpBackend = $httpBackend
      controller = $controller('FeedbacksCtrl', $scope: scope)
      return
    )
    beforeEach ->
      httpBackend.when('GET', '/feedbacks.json').respond 500, 'Internal Server Error'
      spyOn window, 'alert'
      return
    it 'alerts the user on an error', ->
      httpBackend.flush()
      expect(scope.feedbacks).toEqualData []
      expect(window.alert).toHaveBeenCalledWith 'There was a problem: 500'
      return
    return
  return
