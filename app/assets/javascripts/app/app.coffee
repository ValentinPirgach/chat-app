window.app = angular.module 'chat', [
  'ui.router',
  'ng-token-auth',
  'ngActionCable'
]

.run ['$rootScope', '$auth', '$location', 'ActionCableConfig', ($rootScope, $auth, $location, ActionCableConfig) ->
  $rootScope.user = {}

  ActionCableConfig.wsUri= "ws://localhost:3000/cable";
  ActionCableConfig.autoStart = true;

  return
]

.directive 'scrollDownOnChange', () ->
  link: (scope, element, attr) ->
    scope.$watchCollection 'messages.messages.messages', (newValue, oldValue) ->
      console.log scope.messages.messages.isShowMore

      if newValue.length != oldValue.length && !scope.messages.messages.isShowMore
        innerHeight = angular.element(element.children()[0]).height()
        angular.element(element).scrollTop(innerHeight)
        scope.messages.messages.isShowMore = false
        return

    return

.filter 'scrollDownOnChange', () ->
  link: (scope, element, attr) ->
    scope.$watchCollection 'messages.messages.messages', (newValue, oldValue) ->
      console.log scope.messages.messages.isShowMore

      if newValue.length != oldValue.length && !scope.messages.messages.isShowMore
        innerHeight = angular.element(element.children()[0]).height()
        angular.element(element).scrollTop(innerHeight)
        scope.messages.messages.isShowMore = false
        return

    return
