window.mobilemiles = angular.module 'mobilemiles.app', [
  'ngCookies',
  'ngResource',
  'ngSanitize',
  'ngRoute',
  'mobilemiles.common',
  'mobilemiles.auth',
  'mobilemiles.users',
  'mobilemiles.vehicles',
  'mobilemiles.fillups',
  'mobilemiles.location'
]

# Set up default route. Actual routes are defined by modules.
.config ($routeProvider) ->
  $routeProvider
    .otherwise
      redirectTo: '/fillups'

# High-level application controller. Use this to do define app-wide functions
# and scope variables. (Use as minimally as possible)
.controller 'AppCtrl', ['$scope', '$rootScope', ($scope, $rootScope) ->
  
]