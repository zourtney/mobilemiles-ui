angular.module 'mobilemiles.fillups'

.controller 'FillupListCtrl', ['$scope', 'Vehicle', 'Fillup', ($scope, Vehicle, Fillup) ->

  # Default order criteria
  $scope.sortProperty = 'completed_at'

  # Put the full `vehicle` instance on each fillup.
  resolveVehicles = ->
    if $scope.fillups and $scope.vehicles
      _.each $scope.fillups, (f) ->
        f.vehicle = _.find($scope.vehicles, {id: f.vehicle_id})

  $scope.fillups = Fillup.query(resolveVehicles)
  $scope.vehicles = Vehicle.query(resolveVehicles)
]
