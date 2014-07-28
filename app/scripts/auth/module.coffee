angular.module 'mobilemiles.auth', [
  'ngRoute'
  'ngResource'
  'mobilemiles.common'
  'mobilemiles.users'
]

# Define routes
.config ($routeProvider) ->
  $routeProvider.when '/login',
    templateUrl: 'views/auth/login.html',
    controller: 'LoginCtrl'

# Define log out action
.run ['$rootScope', '$location', 'Session', ($rootScope, $location, Session) ->
  $rootScope.$on 'logOut', ->
    Session.destroy()
    $location.path('/login')
]

# Add route to global nav links
.run ['$rootScope', ($rootScope) ->
  ($rootScope.navLinks || = []).push
    icon: 'fa fa-sign-out',
    title: 'Log out',
    position: 100,
    click: -> $rootScope.$broadcast('logOut')
]