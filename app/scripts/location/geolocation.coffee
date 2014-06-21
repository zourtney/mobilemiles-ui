module = angular.module 'mobilemiles.location'

module.factory 'Geolocation', ['$window', '$q', '$rootScope', ($window, $q, $rootScope) -> {

  # http://proccli.com/2013/10/angularjs-geolocation-service
  get: ->
    deferred = $q.defer()

    if $window.navigator
      $window.navigator.geolocation.getCurrentPosition(
        (location) ->
          $rootScope.$apply -> deferred.resolve(location)
        (error) ->
          $rootScope.$apply -> deferred.reject(error)
      )
    else
      $rootScope.$apply -> deferred.reject({ message: 'Geolocation not supported' })

    return deferred.promise

}]