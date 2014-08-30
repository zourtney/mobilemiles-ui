angular.module 'mobilemiles.oilChanges', [
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
  $routeProvider.when '/oilChanges',
    templateUrl: 'views/oilChanges/oilChangeList.html',
    controller: 'OilChangeListCtrl'

  .when '/oilChanges/:id',
    templateUrl: 'views/oilChanges/oilChangeDetails.html',
    controller: 'OilChangeDetailsCtrl',
    resolve:
      oilChangeId: ['$route', ($route) -> $route.current.params.id]
]

# Add route to global nav links
.run ['$rootScope', ($rootScope) ->
  ($rootScope.navLinks || = []).push
    title: 'Oil changes',
    url: '#oilChanges',
    position: 1
]