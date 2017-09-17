class SignupController
  constructor: ($auth) ->
    @authService = $auth
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
        $location.url('/conversations')
      .catch (error) =>
        self.errorMessage = error?.data?.errors?.full_messages[0]

SignupController.$inject = ['$auth']

app
  .component 'signup',
    templateUrl: '/assets/app/components/signup/signup.html'
    controller: SignupController,
    controllerAs: 'signup'
