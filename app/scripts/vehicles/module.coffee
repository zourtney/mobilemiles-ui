angular.module 'mobilemiles.vehicles', [
  'ngRoute'
  'ngResource'
  'ui.bootstrap'
  'angularMoment'
  'mobilemiles.common'
]

# Define routes
.config ($routeProvider) ->
  $routeProvider.when '/vehicles',
    templateUrl: 'views/vehicles/vehicleList.html',
    controller: 'VehicleListCtrl'

  .when '/vehicles/:id',
    templateUrl: 'views/vehicles/vehicleDetails.html',
    controller: 'VehicleDetailsCtrl',
    resolve:
      vehicleId: ['$route', ($route) -> $route.current.params.id]

# Add route to global nav links
.run ($rootScope) ->
  ($rootScope.navLinks || = []).push
    title: 'Vehicles',
    url: '#vehicles',
    position: 0