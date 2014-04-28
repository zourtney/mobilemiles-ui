'use strict';

angular.module('mobilemilesApp')
  .controller('UsersCtrl', ['$scope', 'Users', 'Session', function ($scope, Users, Session) {
    $scope.users = Users.query();
    $scope.session = Session.get(function(data) {
      $scope.user = data.userid;
    });

    $scope.createSession = function(user) {
      Session.save({
        email: user.email,
        password: 'aoeu'
      });
    };
  }]);