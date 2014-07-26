angular.module 'mobilemiles.location'

.directive 'mmGasStationList', [ -> {

  restrict: 'E'
  
  templateUrl: 'views/location/gasStationList.html'
  
  scope:
    mapMetadata: '='
    stations: '='
    ngModel: '='

}]