'use strict';

angular.module('mobilemilesApp')
  .controller('UsersCtrl', ['$scope', '$rootScope', 'Users', 'Session', function ($scope, $rootScope, Users, Session) {
    $scope.users = Users.query();
    //$rootScope.session = Session.get();
    //$scope.session = $rootScope.session;

    $scope.logIn = function() {
      Session.save($scope.loginUser,
        function(data) {
          $rootScope.session = data.session;
          $rootScope.user = data.user;
        },
        function(data) {
          $scope.error = data.data.error;
        }
      );
    };

    $scope.getSession = function() {
      $rootScope.session = Session.get();
    };
  }]);