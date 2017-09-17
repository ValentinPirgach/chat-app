class AuthController
  constructor: ($auth) ->
    @$authService = $auth
    @loginForm =
      email: ''
      password: ''

  $onInit: () ->
    console.log 'init user'

  login: (event) ->
    event.preventDefault

    self = @

    @$authService.submitLogin @loginForm
      .then (resp) ->
        $location.url('/conversations')
      .catch (error) ->
        self.errorMessage = error.data.errors.full_messages[0]

app
  .component 'auth',
    templateUrl: '/assets/app/components/auth/auth.html'
    controller: AuthController,
    controllerAs: 'auth'
