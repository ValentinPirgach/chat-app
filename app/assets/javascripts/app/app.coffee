window.app = angular.module 'chat', [
  'ui.router',
  'ng-token-auth',
]

.run ['$rootScope', '$auth', '$location', ($rootScope, $auth, $location) ->
  $rootScope.user = {}
  return
]
