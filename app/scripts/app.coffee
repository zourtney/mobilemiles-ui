app = angular.module 'mobilemiles.app', [
  'ngCookies',
  'ngResource',
  'ngSanitize',
  'ngRoute',
  'mobilemiles.common',
  'mobilemiles.auth',
  'mobilemiles.users',
  'mobilemiles.vehicles',
  'mobilemiles.fillups'
]

# Set up routes
app.config ($routeProvider) ->
  $routeProvider
    .otherwise
      redirectTo: '/vehicles'


# High-level application controller. Use this to do define app-wide functions
# and scope variables. (Use as minimally as possible)
app.controller 'AppCtrl', ['$scope', '$rootScope', ($scope, $rootScope) ->
  
]