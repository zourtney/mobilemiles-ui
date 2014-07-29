angular.module 'mobilemiles.location'

.directive 'mmGasStationMap', [ -> {

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

    setPhoto = ->
      m = scope.ngModel
      if m and m.photos and m.photos.length
        scope.photo = m.photos[0].getUrl({ maxWidth: 32, maxHeight: 32 })
      else
        scope.photo = ' '   # can't use a standard falsey value...stupid.


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
        setPhoto()

    scope.setStation = (station) ->
      scope.ngModel = station

}]