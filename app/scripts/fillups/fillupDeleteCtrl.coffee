angular.module 'mobilemiles.fillups'

.controller 'FillupDeleteCtrl', ['$scope', '$modalInstance', 'fillup', ($scope, $modalInstance, fillup) ->

  $scope.fillup = fillup

  $scope.cancel = ->
    $modalInstance.dismiss('cancel')

  $scope.ok = ->
    $modalInstance.close()

]