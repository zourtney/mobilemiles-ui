fillups = angular.module 'mobilemiles.fillups'

fillups.controller 'FillupListCtrl', ['$scope', 'Fillup', ($scope, Fillup) ->
  $scope.fillups = Fillup.query()
]
