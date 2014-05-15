module = angular.module 'mobilemilesAuth'

module.factory 'authInterceptor', ['$q', 'authToken', ($q, authToken) -> {

  # Send out auth token in the 'Authorization' header
  request: (config) ->
    config.headers ||= {}
    if authToken.isAuthorized()
      config.headers.Authorization = authToken.getBearerToken()
    return config

  # Update the token whenever one is sent. Currently, this is only done after a
  # successful POST to '/session/'.
  response: (response) ->
    if response.data
      authToken.create(response.data)
    return response || $q.when(response);

  # Any 'Unauthorized' request destroyed your local token. Mean? Maybe, but in
  # practice, this should only happen on a failed login attempt or a request
  # to a secured service with a missing/invalid token.
  responseError: (rejection) ->
    if rejection.status == 401
      authToken.destroy()
    return $q.reject(rejection.data)

}]


module.config ['$httpProvider', ($httpProvider) ->
  $httpProvider.interceptors.push('authInterceptor')
]