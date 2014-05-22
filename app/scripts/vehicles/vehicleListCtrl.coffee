module = angular.module 'mobilemiles.vehicles'

module.controller 'VehicleListCtrl', ['$scope', 'Vehicle', ($scope, Vehicle) ->
  $scope.vehicles = Vehicle.query()
]
