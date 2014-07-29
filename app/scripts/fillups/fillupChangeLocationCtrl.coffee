angular.module 'mobilemiles.fillups'

.controller 'FillupChangeLocationCtrl', ['$scope', '$modalInstance', 'fillup', ($scope, $modalInstance, fillup) ->

  $scope.fillup = fillup
  $scope.coords =
    latitude: fillup.latitude
    longitude: fillup.longitude

  $scope.cancel = ->
    $modalInstance.dismiss('cancel')

  # Resolve with the selected station
  $scope.ok = ->
    $modalInstance.close($scope.coords)

]