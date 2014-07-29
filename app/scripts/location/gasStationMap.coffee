angular.module 'mobilemiles.location'

.directive 'mmGasStationMap', ['GasStation', (GasStation) -> {

  restrict: 'E'
  
  templateUrl: 'views/location/gasStationMap.html'
  
  scope:
    mapMetadata: '='
    stations: '='
    ngModel: '='

  link: (scope, element, attrs) ->

    centerMap = ->
      latLng = scope.ngModel.geometry.location
      scope.mapMetadata.center.latitude = latLng.lat()
      scope.mapMetadata.center.longitude = latLng.lng()

    zoomMap = ->
      scope.mapMetadata.zoom = 16

    zoomTo = true
    scope.$watch 'ngModel', ->
      if scope.ngModel
        # Center on currently selected location.
        centerMap()

        # Zoom in, but only the first time.
        if zoomTo
          zoomMap()
          zoomTo = false

        # Set selected photo
        #TODO: figure out a way to use mm-gas-station-info, and how the window be properly sized
        scope.photoUrl = GasStation.photoUrl(scope.ngModel)

    scope.setStation = (station) ->
      scope.ngModel = station

}]