'use strict'

app = angular.module 'mobilemilesApp', [
  'ngCookies',
  'ngResource',
  'ngSanitize',
  'ngRoute'
]


app.config ($routeProvider) ->
  $routeProvider
    .when '/vehicles',
      templateUrl: 'views/vehicleList.html',
      controller: 'VehicleListCtrl'

    .when '/vehicles/:id',
      templateUrl: 'views/vehicleDetails.html',
      controller: 'VehicleDetailsCtrl',
      resolve:
        vehicleId: ['$route', ($route) -> $route.current.params.id]

    .when '/login',
      templateUrl: 'views/login.html',
      controller: 'LoginCtrl'
  
    .otherwise
      redirectTo: '/vehicles'