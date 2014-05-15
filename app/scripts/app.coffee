angular.module 'mobilemilesUsers', []
angular.module 'mobilemilesAuth', ['mobilemilesUsers']
angular.module 'mobilemilesVehicles', []

app = angular.module 'mobilemilesApp', [
  'ngCookies',
  'ngResource',
  'ngSanitize',
  'ngRoute',
  'mobilemilesUsers',
  'mobilemilesAuth',
  'mobilemilesVehicles'
]


# Contstants
app.constant 'properties',
  BASE_URL: '<%= process.env.SERVER_URL %>',   # environment variable set via grunt
  FIRST_PAGE: '/vehicles'


# Set up routes
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


# High-level application controller. Use this to do define app-wide functions
# and scope variables.
app.controller 'AppCtrl', ['$scope', '$location', 'Session', ($scope, $location, Session) ->
  $scope.logOut = ->
    Session.destroy()
    $location.path('/login')
]