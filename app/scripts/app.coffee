# Constants
angular.module('mobilemilesConst', []).constant 'properties',
  BASE_URL: '<%= process.env.SERVER_URL %>',   # environment variable set via grunt
  FIRST_PAGE: '/vehicles'


angular.module 'mobilemilesUsers', ['mobilemilesConst']
angular.module 'mobilemilesAuth', ['mobilemilesUsers']
angular.module 'mobilemilesVehicles', ['ui.bootstrap']

app = angular.module 'mobilemilesApp', [
  'ngCookies',
  'ngResource',
  'ngSanitize',
  'ngRoute',
  'mobilemilesAuth',
  'mobilemilesVehicles'
]

# Set up routes
app.config ($routeProvider) ->
  $routeProvider
    .when '/vehicles',
      templateUrl: 'views/vehicles/vehicleList.html',
      controller: 'VehicleListCtrl'

    .when '/vehicles/:id',
      templateUrl: 'views/vehicles/vehicleDetails.html',
      controller: 'VehicleDetailsCtrl',
      resolve:
        vehicleId: ['$route', ($route) -> $route.current.params.id]

    .when '/login',
      templateUrl: 'views/auth/login.html',
      controller: 'LoginCtrl'
  
    .otherwise
      redirectTo: '/vehicles'


# High-level application controller. Use this to do define app-wide functions
# and scope variables.
app.controller 'AppCtrl', ['$scope', '$location', 'Session', ($scope, $location, Session) ->
  $scope.logOut = ->
    Session.destroy()
    $location.path('/login')
]