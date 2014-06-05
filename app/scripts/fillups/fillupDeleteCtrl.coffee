module = angular.module 'mobilemiles.fillups'

module.controller 'FillupDeleteCtrl', ['$scope', '$modalInstance', 'fillup', ($scope, $modalInstance, fillup) ->

  $scope.fillup = fillup

  $scope.cancel = ->
    $modalInstance.dismiss('cancel')

  $scope.ok = ->
    $modalInstance.close()

]