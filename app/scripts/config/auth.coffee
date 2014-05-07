'use strict'

app = angular.module 'mobilemilesApp'

app.factory 'authInterceptor', ['$rootScope', '$q', '$window', ($rootScope, $q, $window) -> {

  request: (config) ->
    config.headers ||= {}
    if $window.localStorage.token
      config.headers.Authorization = 'Bearer ' + $window.localStorage.token
    return config

  response: (response) ->
    if response.status == 401
      debugger
    return response || $q.when(response)

}]


app.config ['$httpProvider', ($httpProvider) ->
  $httpProvider.interceptors.push('authInterceptor')
]