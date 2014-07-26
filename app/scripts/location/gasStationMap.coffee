angular.module 'mobilemiles.location'

.directive 'mmGasStationMap', [ -> {

  restrict: 'E'
  
  templateUrl: 'views/location/gasStationMap.html'
  
  scope:
    mapMetadata: '='
    stations: '='
    ngModel: '='
    latitude: '='
    longitude: '='

  link: (scope, element, attrs) ->

    centerMap = (latLng) ->
        scope.mapMetadata.center.latitude = latLng.lat()
        scope.mapMetadata.center.longitude = latLng.lng()
        scope.mapMetadata.zoom = 16

    #TOOD: fix issue where the function is getting called twice.
    # scope.$watch 'longitude', centerMap
    # scope.$watch 'latitude', centerMap

    scope.$watch 'ngModel', () ->
      if scope.ngModel
        console.log('centering on ', scope.ngModel)
        centerMap(scope.ngModel.geometry.location)

}]