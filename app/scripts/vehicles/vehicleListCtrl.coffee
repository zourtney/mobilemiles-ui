module = angular.module 'mobilemiles.vehicles'

module.controller 'VehicleListCtrl', ['$scope', 'Vehicle', 'Fillup', ($scope, Vehicle, Fillup) ->

  $scope.sortProperty = 'name'
  
  $scope.vehicles = Vehicle.query( () ->
    _.each $scope.vehicles, (v) ->
      v.fillups = Fillup.query({ vehicle_id: v.id })   #TODO: use a "count_only" approach instead
  )

]
