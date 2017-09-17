window.app = angular.module 'chat', [
  'ngRoute',
  'ng-token-auth',
]

.run ['$rootScope', '$auth', '$location', ($rootScope, $auth, $location) ->
  $rootScope.user = {}

  $rootScope.$on '$locationChangeStart', (event) ->
    url = $location.url()

    # if url == '/login' or url == '/signup'
    #   event.preventDefault()
    #
    #   $auth.validateUser().then (user) ->
    #     $rootScope.user = user
    #     $location.url('/conversations') if $rootScope.user.signedIn


  return
]
