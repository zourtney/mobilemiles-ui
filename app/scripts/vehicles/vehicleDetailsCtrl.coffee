'use strict';

vehicles = angular.module 'mobilemilesVehicles'

vehicles.controller 'VehicleDetailsCtrl', ['$scope', 'Vehicle', 'vehicleId', ($scope, Vehicle, vehicleId) ->
  $scope.vehicle = Vehicle.get({ id: vehicleId })
]
