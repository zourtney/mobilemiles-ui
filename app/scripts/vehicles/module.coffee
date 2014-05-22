module = angular.module 'mobilemiles.vehicles', [
  'ngRoute'
  'ngResource'
  'ui.bootstrap'
  'mobilemiles.common'
]

module.config ($routeProvider) ->
  $routeProvider.when '/vehicles',
    templateUrl: 'views/vehicles/vehicleList.html',
    controller: 'VehicleListCtrl'

  .when '/vehicles/:id',
    templateUrl: 'views/vehicles/vehicleDetails.html',
    controller: 'VehicleDetailsCtrl',
    resolve:
      vehicleId: ['$route', ($route) -> $route.current.params.id]
