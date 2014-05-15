'use strict'

vehicles = angular.module 'mobilemilesVehicles'

vehicles.controller 'VehicleListCtrl', ['$scope', 'Vehicle', ($scope, Vehicle) ->
  $scope.vehicles = Vehicle.query()
]
