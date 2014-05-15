'use strict'

app = angular.module 'mobilemilesApp'


# Simple encapsulation of 'token' persistence. Currently just uses
# the browser's `localStorage`.
app.factory 'authToken', ['$window', ($window) -> {
  isAuthorized: ->
    return !!$window.localStorage.token
  create: (val) ->
    $window.localStorage.token = val
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
app.factory 'Session', ['$http', '$q', 'properties', 'authToken', ($http, $q, properties, authToken) -> {

  isAuthorized: ->
    return authToken.isAuthorized()
  
  create: (email, password) ->
    deferred = $q.defer()

    credentials = {
      email: email,
      password: password
    }
    $http.post(properties.BASE_URL + '/session/', credentials)
      .success (data) ->
        authToken.create(data.token)
        deferred.resolve(data.token)
      .error (data) ->
        authToken.destroy()
        deferred.reject()

  destroy: ->
    #TODO: invalidate on the server?
    authToken.destroy();
}]