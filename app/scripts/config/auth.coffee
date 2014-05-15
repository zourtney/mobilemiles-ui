'use strict'

app = angular.module 'mobilemilesApp'


app.factory 'authInterceptor', ['authToken', (authToken) -> {

  request: (config) ->
    config.headers ||= {}
    if authToken.isAuthorized()
      config.headers.Authorization = authToken.getBearerToken()
    return config

  responseError: (rejection) ->
    if response.status == 401
      authToken.destroy()

}]


app.config ['$httpProvider', ($httpProvider) ->
  $httpProvider.interceptors.push('authInterceptor')
]