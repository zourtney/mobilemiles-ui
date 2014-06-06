module = angular.module 'mobilemiles.vehicles', [
  'ngRoute'
  'ngResource'
  'ui.bootstrap'
  'mobilemiles.common'
]

# Define routes
module.config ($routeProvider) ->
  $routeProvider.when '/vehicles',
    templateUrl: 'views/vehicles/vehicleList.html',
    controller: 'VehicleListCtrl'

  .when '/vehicles/:id',
    templateUrl: 'views/vehicles/vehicleDetails.html',
    controller: 'VehicleDetailsCtrl',
    resolve:
      vehicleId: ['$route', ($route) -> $route.current.params.id]

# Add route to global nav links
module.run ($rootScope) ->
  ($rootScope.navLinks || = []).push
    title: 'Vehicles',
    url: '#vehicles',
    position: 0