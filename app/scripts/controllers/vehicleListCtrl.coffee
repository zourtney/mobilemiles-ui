'use strict'

app = angular.module 'mobilemilesApp'

app.controller 'VehicleListCtrl', ['$scope', 'Vehicle', ($scope, Vehicle) ->

  $scope.vehicles = Vehicle.query()

]
