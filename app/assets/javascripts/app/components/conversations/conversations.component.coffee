class ConversationsController
  constructor: ($http, $state, $stateParams, $auth) ->
    @http = $http
    @state = $state
    @auth = $auth
    @stateParams = $stateParams
    @users = []

  $onInit: () ->
    @auth.validateUser().then (resp) =>
      @current_user = resp

    @userLoading = true
    @http.get 'http://localhost:3000/available_users'
      .then (resp) =>
        @users = resp.data.map (user) =>
          Object.assign user,
            active: user.id == Number @stateParams.recipient_id
        @userLoading = false
        @createConversation @stateParams.recipient_id if @stateParams.recipient_id

  createConversation: (recipient_id) ->
    @http.post 'http://localhost:3000/conversations', {recipient_id: recipient_id}
      .then (resp) =>
        @conversation = resp.data

  activate: (user) ->
    for u in @users
      u.active = no
    user.active = yes

    @createConversation user.id
      .then (resp) =>
        @state.go 'conversations.recipient', recipient_id: user.id, conversation_id: resp.id

  logout: () ->
    @auth.signOut().then () =>
      @state.go 'login'

ConversationsController.$inject = ['$http', '$state', '$stateParams', '$auth']

app
  .component 'conversations',
    templateUrl: '/assets/app/components/conversations/conversations.html'
    controller: ConversationsController,
    controllerAs: 'conv'
