angular.module 'mobilemiles.fillups'

.controller 'FillupChangeLocationCtrl', ['$scope', '$modalInstance', 'mapMetadata', 'stations', 'selectedStation', ($scope, $modalInstance, mapMetadata, stations, selectedStation) ->

  $scope.mapMetadata = mapMetadata
  $scope.stations = stations
  $scope.selected =
    station: selectedStation

  $scope.$watch 'selected.station', ->
    station = $scope.selected.station
    if station and station.photos and station.photos.length > 0
      $scope.selected.photo = station.photos[0].getUrl
        maxWidth: 64,
        maxHeight: 64
    else
      $scope.selected.photo = ' '   # can't use a standard falsey value...stupid.

  $scope.cancel = ->
    $modalInstance.dismiss('cancel')

  # Resolve with the selected station
  $scope.ok = ->
    $modalInstance.close($scope.selected.station)

]