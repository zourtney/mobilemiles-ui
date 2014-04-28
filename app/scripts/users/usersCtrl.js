'use strict';

angular.module('mobilemilesApp')
  .controller('UsersCtrl', function ($scope) {
    $scope.users = [
      {
        email: 'fake@local.com',
        password: 'redactedyo'
      }
    ];
  });