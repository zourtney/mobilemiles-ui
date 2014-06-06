module = angular.module 'mobilemiles.fillups'

module.controller 'FillupChangeTimeCtrl', ['$scope', '$modalInstance', 'fillup', ($scope, $modalInstance, fillup) ->

  $scope.fillup = fillup

  #TODO: abstract this out
  $scope.days = (i for i in [1..31])
  $scope.months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December']
  $scope.years = (i for i in [new Date().getFullYear()..2011])
  $scope.hours = (i for i in [1..12])
  $scope.minutes = (i for i in [1..59])
  $scope.amPm = ['AM', 'PM']

  # Set components
  # completedAt = new Date($scope.fillup.completed_at)
  # $scope.day = completedAt.getDate();
  # $scope.month = $scope.months[completedAt.getMonth()]
  # $scope.year = completedAt.getFullYear()
  # $scope.hour = completedAt.getHours() % 12
  # $scope.minute = completedAt.getMinutes()
  # $scope.isPm = $scope.amPm[if completedAt.getHours() < 12 then 0 else 1]
  
  $scope.cancel = ->
    $modalInstance.dismiss('cancel')

  $scope.ok = ->
    # Update the model, then return
    $scope.fillup.completed_at = new Date(
      $scope.year,
      $scope.months.indexOf($scope.month),
      $scope.day,
      $scope.hour + (if $scope.isPm then 12 else 0),
      $scope.minute
    ).getTime()
    console.log($scope.year, $scope.month, $scope.day, new Date($scope.fillup.completed_at))
    #$modalInstance.close()

]