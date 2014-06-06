module = angular.module 'mobilemiles.auth', [
  'ngRoute'
  'ngResource'
  'mobilemiles.common'
  'mobilemiles.users'
]

# Define routes
module.config ($routeProvider) ->
  $routeProvider.when '/login',
    templateUrl: 'views/auth/login.html',
    controller: 'LoginCtrl'

# Define log out action
module.run ['$rootScope', '$location', 'Session', ($rootScope, $location, Session) ->
  $rootScope.$on 'logOut', ->
    Session.destroy()
    $location.path('/login')
]

# Add route to global nav links
module.run ($rootScope) ->
  ($rootScope.navLinks || = []).push
    icon: 'fa fa-sign-out',
    title: 'Log out',
    position: 100,
    click: -> $rootScope.$broadcast('logOut')