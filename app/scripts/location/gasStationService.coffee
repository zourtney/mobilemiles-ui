module = angular.module 'mobilemiles.location'

module.factory 'GasStation', ['$q', ($q) -> {

  nearby: (map, coords) ->
    deferred = $q.defer()

    service = new google.maps.places.PlacesService(map)

    criteria =
      location: new google.maps.LatLng(coords.latitude, coords.longitude),
      types: ['gas_station'],
      rankBy: google.maps.places.RankBy.DISTANCE

    service.nearbySearch criteria, (results, status) -> 
      if status == google.maps.places.PlacesServiceStatus.OK
        deferred.resolve(results)
      else
        deferred.reject(status)

    return deferred.promise

}]