'use strict'

vehicles = angular.module 'mobilemilesVehicles'

vehicles.controller 'VehicleListCtrl', ['$scope', 'Vehicle', ($scope, Vehicle) ->
  
  $scope.vehicles = Vehicle.query()

  # $scope.add ->
  #   Vehicle.create {}, (data) ->
  #     $scope.vehicles.push(data)

]
