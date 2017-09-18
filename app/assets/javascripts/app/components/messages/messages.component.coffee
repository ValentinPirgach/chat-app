class MessagesController
  constructor: ($http, $state, $stateParams, $auth, ActionCableChannel, $timeout) ->
    @http = $http
    @state = $state
    @auth = $auth
    @ActionCableChannel = ActionCableChannel

    @stateParams = $stateParams
    @new_message =
      body: ''
    @messages = {messages:[]}
    @page = 1

  sendMessage: () ->
    @new_message.user_id = @current_user.id

    @http.post 'http://localhost:3000/messages', message: @new_message, conversation_id: @stateParams.conversation_id
      .then (resp) =>
        @new_message.body = ''

  showMore: () ->
    @messages.isShowMore = true
    @http.get "http://localhost:3000/messages?conversation_id=#{@stateParams.conversation_id}&page=#{++@page}"
      .then (resp) =>
        resp.data.messages.map (m) =>
          @messages.messages.unshift m

  $onDestroy: () ->
    @consumer.unsubscribe()

  $onInit: () ->
    @consumer = new @ActionCableChannel 'ConversationChannel', conversation: @stateParams.conversation_id

    @consumer.subscribe (message) =>
      @messages.messages.push(message)

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
