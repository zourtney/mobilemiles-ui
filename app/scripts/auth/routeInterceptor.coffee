angular.module 'mobilemiles.auth'

.run ['$rootScope', '$location', 'Session', ($rootScope, $location, Session) ->
  
  $rootScope.$on '$routeChangeStart', (event, next) ->
    if ! Session.isAuthorized() && next.templateUrl != 'views/login.html'
      $location.path('/login')

    # Always set fullscreen to false. The page controller can override it if needed.
    # (Yes, this should probably go somewhere else)
    $rootScope.isFullscreen = false
]