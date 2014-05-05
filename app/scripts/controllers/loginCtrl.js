'use strict';

angular.module('mobilemilesApp')
  .controller('LoginCtrl', ['$scope', '$rootScope', '$location', 'properties', 'User', 'Session', function ($scope, $rootScope, $location, properties, User, Session) {

    // Only triggered by the offscreen 'submit' button (via 'enter' probably).
    $scope.onSubmit = function() {
      if ($scope.registerMode) {
        $scope.register();
      }
      else {
        $scope.logIn();
      }
    };
    
    $scope.logIn = function() {
      $scope.isBusy = true;

      var session = new Session();
      session.email = $scope.email;
      session.password = $scope.password;
      
      session.$save()
        .then(function(data) {
          $rootScope.session = data.session;
          $rootScope.user = data.user;
          $location.path(properties.FIRST_PAGE);
        })
        .catch(function(data) {
          $scope.error = data.data.error;
        })
        .finally(function() {
          $scope.isBusy = false;
        });
    };

    $scope.register = function() {
      if ($scope.password !== $scope.passwordConfirm) {
        $scope.error = 'Passwords do not match.';
      }
      else {
        $scope.isBusy = true;

        var user = new User();
        user.user = {
          email: $scope.email,
          password: $scope.password
        };

        user.$save()
          .then(function() {
            $scope.logIn();
          })
          .catch(function(data) {
            console.error(data);
            $scope.error = 'Unknown error occurred while registering.';
          })
          .finally(function() {
            $scope.isBusy = false;
          });
      }
    };

  }]);