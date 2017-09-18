class MessagesController
  constructor: ($http, $state, $stateParams, $auth) ->
    @http = $http
    @state = $state
    @auth = $auth
    @stateParams = $stateParams
    @new_message =
      body: ''
    @messages = []

  sendMessage: () ->
    @new_message.user_id = @current_user.id

    @http.post 'http://localhost:3000/messages', message: @new_message, conversation_id: @stateParams.conversation_id
      .then (resp) =>
        @new_message.body = ''
        console.log resp

  $onInit: () ->
    @auth.validateUser().then (resp) =>
      @current_user = resp

      @http.get "http://localhost:3000/messages?conversation_id=#{@stateParams.conversation_id}"
        .then (resp) =>
          @messages = resp.data

  formatTime: (time) ->
    moment(time).format('MM.DD.YY hh:mm a')
app
  .component 'messages',
    templateUrl: '/assets/app/components/messages/messages.html'
    controller: MessagesController,
    controllerAs: 'messages'
