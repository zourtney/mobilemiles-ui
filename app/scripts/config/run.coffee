'use strict'

app = angular.module 'mobilemilesApp'

app.run ['$rootScope', '$location', '$window', 'Session', ($rootScope, $location, $window, Session) ->
  $rootScope.$on '$routeChangeStart', (event, next) ->
    if (! $rootScope.user && next.templateUrl != 'views/login.html')
      $location.path('/login')
]