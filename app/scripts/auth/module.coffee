module = angular.module 'mobilemiles.auth', [
  'ngRoute'
  'ngResource'
  'mobilemiles.common'
  'mobilemiles.users'
]

module.config ($routeProvider) ->
  $routeProvider.when '/login',
    templateUrl: 'views/auth/login.html',
    controller: 'LoginCtrl'

module.run ['$rootScope', '$location', 'Session', ($rootScope, $location, Session) ->
  $rootScope.$on 'logOut', ->
    Session.destroy()
    $location.path('/login')
]