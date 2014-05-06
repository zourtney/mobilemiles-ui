'use strict';

app = angular.module 'mobilemilesApp'

app.controller 'VehiclesCtrl', ['$scope', 'Vehicle', ($scope, Vehicle) ->

  $scope.vehicles = Vehicle.query()

]
