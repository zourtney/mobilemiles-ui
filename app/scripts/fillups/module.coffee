module = angular.module 'mobilemiles.fillups', [
  'ngRoute'
  'ngResource'
  'mobilemiles.common'
]

module.config ($routeProvider) ->
  $routeProvider.when '/fillups',
    templateUrl: 'views/fillups/fillupList.html',
    controller: 'FillupListCtrl'