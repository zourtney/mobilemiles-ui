module = angular.module 'mobilemiles.vehicles'

module.controller 'VehicleDeleteCtrl', ['$scope', '$modalInstance', 'vehicle', ($scope, $modalInstance, vehicle) ->

  $scope.vehicle = vehicle

  $scope.cancel = ->
    $modalInstance.dismiss('cancel')

  $scope.ok = ->
    $modalInstance.close()

]