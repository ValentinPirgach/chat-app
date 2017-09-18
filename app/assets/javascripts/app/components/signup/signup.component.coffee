class SignupController
  constructor: ($auth, $state) ->
    @authService = $auth
    @state = $state

    @user =
      name: ''
      email: ''
      password: ''
      password_confirmation: ''

  register: (event) ->
    event.preventDefault
    self = @

    @user.password_confirmation = @user.password

    @authService.submitRegistration @user
      .then (resp) =>
        self.state.go('conversations.index')
      .catch (error) =>
        self.errorMessage = error?.data?.errors?.full_messages[0]

SignupController.$inject = ['$auth', '$state']

app
  .component 'signup',
    templateUrl: '/assets/app/components/signup/signup.html'
    controller: SignupController,
    controllerAs: 'signup'
