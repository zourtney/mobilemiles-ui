angular.module 'mobilemiles.location'

.directive 'mmGasStationInfo', ['GasStation', (GasStation) -> {

  restrict: 'E'
  templateUrl: 'views/location/gasStationInfo.html'
  scope:
    ngModel: '='
  link: (scope, element, attrs) ->
    scope.$watch 'ngModel', ->
      scope.photoUrl = GasStation.photoUrl(scope.ngModel)

}]