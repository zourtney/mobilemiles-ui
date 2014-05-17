module = angular.module 'mobilemilesAuth'

# Simple encapsulation of 'token' persistence. Currently just uses
# the browser's `localStorage`.
module.factory 'authToken', ['$window', ($window) -> {
  isAuthorized: ->
    return !!$window.localStorage.token
  create: (val) ->
    if val.token then $window.localStorage.token = val.token
  destroy: ->
    delete $window.localStorage.token
  getBearerToken: ->
    return 'Bearer ' + $window.localStorage.token
}]


# Session management. Note that this should be treated as a singleton.
# For example:
#
#    Session.create('some@dude.com', 'aoeu')
#      .then(function() {...})
#      .catch(function() {...})
#    ;
#
#    ...
#
#    Session.destroy();
module.factory 'Session', ['$http', '$q', 'properties', 'authToken', ($http, $q, properties, authToken) -> {

  isAuthorized: ->
    return authToken.isAuthorized()
  
  create: (email, password) ->
    return $http.post(properties.BASE_URL + '/session/', {
      email: email,
      password: password
    })

  destroy: ->
    #TODO: invalidate on the server?
    authToken.destroy()
}]