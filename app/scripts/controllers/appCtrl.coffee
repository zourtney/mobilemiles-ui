'use strict';

app = angular.module 'mobilemilesApp'

app.controller 'AppCtrl', ['$scope', '$location', 'Session', ($scope, $location, Session) ->

  $scope.logOut = ->
    Session.destroy()
    $location.path('/login')

]