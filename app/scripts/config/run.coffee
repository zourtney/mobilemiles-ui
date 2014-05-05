'use strict'

app = angular.module 'mobilemilesApp'

app.run ['$rootScope', '$location', ($rootScope, $location) ->
  $rootScope.$on '$routeChangeStart', (event, next) ->
    if (! $rootScope.user && next.templateUrl != 'views/login.html')
      $location.path('/login')
]