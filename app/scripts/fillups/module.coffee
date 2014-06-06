module = angular.module 'mobilemiles.fillups', [
  'ngRoute'
  'ui.bootstrap'
  'ngResource'
  'mobilemiles.common'
  'mobilemiles.vehicles'
]

# Define routes
module.config ($routeProvider) ->
  $routeProvider.when '/fillups',
    templateUrl: 'views/fillups/fillupList.html',
    controller: 'FillupListCtrl'

  .when '/fillups/:id',
    templateUrl: 'views/fillups/fillupDetails.html',
    controller: 'FillupDetailsCtrl',
    resolve:
      fillupId: ['$route', ($route) -> $route.current.params.id]

# Add route to global nav links
module.run ($rootScope) ->
  ($rootScope.navLinks || = []).push
    title: 'Fill-ups',
    url: '#fillups',
    position: 1