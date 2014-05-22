fillups = angular.module 'mobilemiles.fillups'

fillups.controller 'FillupListCtrl', ['$scope', 'Fillups', ($scope, Fillups) ->
  $scope.fillups = Fillups.query()
]
