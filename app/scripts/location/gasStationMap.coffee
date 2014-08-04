angular.module 'mobilemiles.location'

.directive 'mmGasStationMap', ['$rootScope', 'GasStation', ($rootScope, GasStation) -> {

  restrict: 'E'
  
  templateUrl: 'views/location/gasStationMap.html'
  
  scope:
    mapMetadata: '='
    stations: '='
    ngModel: '='
    geoCoords: '='

  link: (scope, element, attrs) ->

    # Options for the "you are here" circle
    scope.$watch 'ngModel', ->
      if scope.ngModel
        # Set selected photo
        #TODO: figure out a way to use mm-gas-station-info, and how the window be properly sized
        scope.photoUrl = GasStation.photoUrl(scope.ngModel)

    scope.setStation = (station) ->
      scope.ngModel = station
      $rootScope.$digest()   # needed, otherwise the `isCurrentStation` check doesn't re-run until panning.

    scope.isCurrentStation = (station) ->
      scope.ngModel.id == station.id

}]