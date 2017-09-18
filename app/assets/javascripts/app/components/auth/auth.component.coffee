class AuthController
  constructor: ($auth, $state) ->
    @$authService = $auth
    @state = $state

    @loginForm =
      email: ''
      password: ''

  login: (event) ->
    event.preventDefault

    self = @

    @$authService.submitLogin @loginForm
      .then (resp) ->
        self.state.go('conversations.index')
      .catch (error) ->
        self.errorMessage = error.errors[0] if error.errors[0]

app
  .component 'auth',
    templateUrl: '/assets/app/components/auth/auth.html'
    controller: AuthController,
    controllerAs: 'auth'
