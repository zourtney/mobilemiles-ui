'use strict';

angular.module('mobilemilesApp')
  .directive('momiUserInfo', [function() {
    return {
      restrict: 'E',
      templateUrl: 'views/userInfo.html',
      scope: {
        session: '=',
        user: '='
      },
      link: function(/*scope, el*/) {
        //scope.hai = 'hello';
      }
    };
  }]);