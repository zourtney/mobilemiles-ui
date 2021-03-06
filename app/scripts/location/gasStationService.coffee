angular.module 'mobilemiles.location'

.factory 'GasStation', ['$q', ($q) -> {

  nearby: (map, latitude, longitude) ->
    deferred = $q.defer()

    service = new google.maps.places.PlacesService(map)

    criteria =
      location: new google.maps.LatLng(latitude, longitude),
      types: ['gas_station'],
      rankBy: google.maps.places.RankBy.DISTANCE

    service.nearbySearch criteria, (results, status) -> 
      if status == google.maps.places.PlacesServiceStatus.OK
        deferred.resolve(results)
      else
        deferred.reject(status)

    return deferred.promise

  getDetails: (map, referenceNumber) ->
    deferred = $q.defer();

    service = new google.maps.places.PlacesService(map)

    criteria =
      reference: referenceNumber

    service.getDetails criteria, (results, status) -> 
      if status == google.maps.places.PlacesServiceStatus.OK
        deferred.resolve(results)
      else
        deferred.reject(status)

    return deferred.promise

  photoUrl: (place, w=32, h=32) ->
    if place and place.photos and place.photos.length
      return place.photos[0].getUrl({ maxWidth: w, maxHeight: h })
    return ' '   # can't use a standard falsey value...stupid.

}]