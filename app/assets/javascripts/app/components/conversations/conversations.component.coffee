class ConversationsController
  constructor: ($http) ->
    @http = $http
    @users = []

  $onInit: () ->
    @http.get 'http://localhost:3000/available_users'
      .then (resp) =>
        @users = resp.data

  activate: (user) ->
    for user in @users
      user.active = no

    user.active = yes

    console.log user

ConversationsController.$inject = ['$http']

app
  .component 'conversations',
    templateUrl: '/assets/app/components/conversations/conversations.html'
    controller: ConversationsController,
    controllerAs: 'conv'
