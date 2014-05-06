'use strict'

app = angular.module 'mobilemilesApp'
deps = ['$rootScope', '$location']

app.run [deps, ($rootScope, $location) ->
  $rootScope.$on '$routeChangeStart', (event, next) ->
    if (! $rootScope.user && next.templateUrl != 'views/login.html')
      $location.path('/login')
]