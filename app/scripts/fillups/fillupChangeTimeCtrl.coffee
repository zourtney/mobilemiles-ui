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
  completedAt = new Date($scope.fillup.completed_at)
  $scope.completedAt = {
    day: completedAt.getDate();
    month: $scope.months[completedAt.getMonth()]
    year: completedAt.getFullYear()
    hour: completedAt.getHours() % 12
    minute: completedAt.getMinutes()
    isPm: $scope.amPm[if completedAt.getHours() < 12 then 0 else 1]
  }
  
  $scope.cancel = ->
    $modalInstance.dismiss('cancel')

  $scope.ok = ->
    # Update the model, then return
    $scope.fillup.completed_at = new Date(
      $scope.completedAt.year,
      $scope.months.indexOf($scope.completedAt.month),
      $scope.completedAt.day,
      $scope.completedAt.hour + (if $scope.completedAt.isPm == 'PM' then 12 else 0),
      $scope.completedAt.minute
    ).getTime()
    $modalInstance.close()

]