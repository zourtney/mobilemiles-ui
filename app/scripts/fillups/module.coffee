angular.module 'mobilemiles.fillups', [
  'ngRoute'
  'ui.bootstrap'
  'ngResource'
  'angularMoment'
  'mobilemiles.common'
  'mobilemiles.vehicles'
  'mobilemiles.location'
]

# Define routes
.config ['$routeProvider', ($routeProvider) ->
  $routeProvider.when '/fillups',
    templateUrl: 'views/fillups/fillupList.html',
    controller: 'FillupListCtrl'

  .when '/fillups/:id',
    templateUrl: 'views/fillups/fillupDetails.html',
    controller: 'FillupDetailsCtrl',
    resolve:
      fillupId: ['$route', ($route) -> $route.current.params.id]
]

# Add route to global nav links
.run ['$rootScope', ($rootScope) ->
  ($rootScope.navLinks || = []).push
    title: 'Fill-ups',
    url: '#fillups',
    position: 1
]