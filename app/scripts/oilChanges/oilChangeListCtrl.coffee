angular.module 'mobilemiles.oilChanges'

.controller 'OilChangeListCtrl', ['$scope', 'Vehicle', 'OilChange', ($scope, Vehicle, OilChange) ->

  # Default order criteria
  $scope.sortProperty = 'completed_at'

  # Put the full `vehicle` instance on each oil change.
  resolveVehicles = ->
    if $scope.oilChanges and $scope.vehicles
      _.each $scope.oilChanges, (f) ->
        f.vehicle = _.find($scope.vehicles, {id: f.vehicle_id})

  $scope.oilChanges = OilChange.query(resolveVehicles)
  $scope.vehicles = Vehicle.query(resolveVehicles)
]
