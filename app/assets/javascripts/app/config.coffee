app.config ['$authProvider', ($authProvider) ->
    $authProvider.configure apiUrl: 'http://localhost:3000'
    return
]

app.config ['$httpProvider', ($httpProvider) ->
    $httpProvider.defaults.headers.common = 'application/json'
    return
]

app.config ['$stateProvider', '$urlRouterProvider', '$locationProvider'
  ($stateProvider, $urlRouterProvider, $locationProvider) ->
    $locationProvider.hashPrefix('');
    $urlRouterProvider.otherwise('/conversations');

    $stateProvider
      .state 'login',
        url: '/login'
        template: '<auth></auth>'
      .state 'signup',
        url: '/signup'
        template: '<signup></signup>'
      .state 'conversations',
        abstract: true
        template: '<conversations></conversations>'
        resolve:
          auth: ['$auth', '$state', ($auth, $state) ->
            $state.go('login') if $auth.validateUser().$$state.status == 2
            return $auth.validateUser()
          ]

      .state 'conversations.index',
        url: '/conversations'
        template: '<div class="info-text">Please select contact to start converstation</div>'
      .state 'conversations.recipient',
        url: '/conversations/recipient/:recipient_id/conversation/:conversation_id'
        template: '<messages></messages>'

      # .when '/signup',
      #   template: '<signup></signup>'
      # .when '/conversations',
      #   template: '<conversations></conversations>'
      # .when '/conversations/:recipient_id',
      #   template: '<conversations></conversations>',
      #   reloadOnSearch: no
]
