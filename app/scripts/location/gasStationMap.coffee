angular.module 'mobilemiles.location'

.directive 'mmGasStationMap', [ -> {

  restrict: 'E'
  
  templateUrl: 'views/location/gasStationMap.html'
  
  scope:
    mapMetadata: '='
    stations: '='
    ngModel: '='

  link: (scope, element, attrs) ->

    scope.$watch 'ngModel', () ->
      if scope.ngModel
        latLng = scope.ngModel.geometry.location
        scope.mapMetadata.center.latitude = latLng.lat()
        scope.mapMetadata.center.longitude = latLng.lng()
        scope.mapMetadata.zoom = 16

}]