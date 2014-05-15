'use strict';

app = angular.module 'mobilemilesApp'

app.controller 'VehicleDetailsCtrl', ['$scope', 'Vehicle', 'vehicleId', ($scope, Vehicle, vehicleId) ->

  $scope.vehicle = Vehicle.get({ id: vehicleId })

]
