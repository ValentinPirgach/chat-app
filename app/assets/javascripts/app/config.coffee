app.config ['$authProvider', ($authProvider) ->
    $authProvider.configure apiUrl: 'http://localhost:3000'
    return
]

app.config ['$httpProvider', ($httpProvider) ->
    $httpProvider.defaults.headers.common = 'application/json'
    return
]

app.config ['$locationProvider', '$routeProvider',
  ($locationProvider, $routeProvider) ->
    $locationProvider.hashPrefix ''

    $routeProvider
      .when '/login',
        template: '<auth></auth>'
      .when '/signup',
        template: '<signup></signup>'
      .when '/conversations',
        template: '<conversations></conversations>'
]
