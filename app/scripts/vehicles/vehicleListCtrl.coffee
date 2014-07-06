angular.module 'mobilemiles.vehicles'

.controller 'VehicleListCtrl', ['$scope', 'Vehicle', ($scope, Vehicle) ->

  $scope.sortProperty = 'name'
  $scope.vehicles = Vehicle.query()

]
