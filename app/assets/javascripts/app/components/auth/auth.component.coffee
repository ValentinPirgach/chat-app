class AuthController
  constructor: () ->

  $onInit: () ->
    console.log 'init user'

app
  .component 'auth',
    templateUrl: '/assets/app/components/auth/auth.html'
    controller: AuthController,
    controllerAs: 'Auth'
