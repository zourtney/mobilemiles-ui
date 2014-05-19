vehicles = angular.module 'mobilemilesVehicles'

vehicles.controller 'VehicleDeleteCtrl', ['$scope', '$modalInstance', 'vehicle', ($scope, $modalInstance, vehicle) ->

  $scope.vehicle = vehicle

  $scope.cancel = ->
    $modalInstance.dismiss('cancel')

  $scope.ok = ->
    $modalInstance.close()

]