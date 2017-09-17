app.config ['$authProvider', ($authProvider) ->
    $authProvider.configure apiUrl: '/api'
    return
]

app.config ['$locationProvider', '$routeProvider',
  ($locationProvider, $routeProvider) ->
    $locationProvider.hashPrefix ''

    $routeProvider
      .when '/',
        template: '<auth></auth>'
]
