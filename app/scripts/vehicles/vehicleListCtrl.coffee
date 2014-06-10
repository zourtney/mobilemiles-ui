module = angular.module 'mobilemiles.vehicles'

module.controller 'VehicleListCtrl', ['$scope', 'Vehicle', ($scope, Vehicle) ->

  $scope.sortProperty = 'name'
  $scope.vehicles = Vehicle.query()

]
