'use strict';

angular.module('mobilemilesApp')
  .run(['$rootScope', '$location', function($rootScope, $location) {
    $rootScope.$on('$routeChangeStart', function(event, next /*, current*/) {
      if (! $rootScope.user && next.templateUrl !== 'views/login.html') {
        $location.path('/login');
      }
    });
  }]);