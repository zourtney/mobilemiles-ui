'use strict';

angular
  .module('mobilemilesApp', [
    'ngCookies',
    'ngResource',
    'ngSanitize',
    'ngRoute',
  ])
  .config(function ($routeProvider) {
    $routeProvider
      .when('/', {
        templateUrl: 'views/users.html',
        controller: 'UsersCtrl'
      })
      .otherwise({
        redirectTo: '/'
      });
  });
