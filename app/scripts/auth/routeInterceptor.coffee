module = angular.module 'mobilemiles.auth'

module.run ['$rootScope', '$location', 'Session', ($rootScope, $location, Session) ->
  
  $rootScope.$on '$routeChangeStart', (event, next) ->
    if ! Session.isAuthorized() && next.templateUrl != 'views/login.html'
     $location.path('/login')

]