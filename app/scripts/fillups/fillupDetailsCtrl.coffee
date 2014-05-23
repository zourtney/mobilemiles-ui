module = angular.module 'mobilemiles.fillups'

module.controller 'FillupDetailsCtrl', ['$scope', '$modal', '$location', 'Grades', 'Vehicle', 'Fillup', 'fillupId', ($scope, $modal, $location, Grades, Vehicle, Fillup,  fillupId) ->

  $scope.vehicles = Vehicle.query();
  $scope.grades = Grades.query();
  
  # Fetch the existing vehicle, or make a new empty one
  if fillupId == 'new'
    $scope.isNew = true
    $scope.fillup = new Fillup()
  else
    Fillup.get({ id: fillupId }).$promise
      .then (data) ->
        $scope.fillup = data
      .catch (data) ->
        $scope.fillup = null

  # Convenience function for telling the state of in-progress AJAX requests
  $scope.isBusy = ->
    return $scope.isSaving || $scope.isDeleting

  # Create or update the resource on the server
  $scope.save = ->
    $scope.isSaving = true
    method = if $scope.isNew then '$save' else '$update' 

    $scope.fillup[method]()
      .then ->
        if $scope.isNew
          $location.path('/fillups/' + $scope.fillup.id)
        $scope.isNew = false
      .catch (data) ->
        $scope.errorMessage = data.error || 'Unknown error'
      .finally ->
        $scope.isSaving = false

  # Delete the resource :'( On success, redirect to list page
  # $scope.delete = ->
  #   $scope.isDeleting = true

  #   modalInstance = $modal.open
  #     templateUrl: 'views/fillups/vehicleDelete.html',
  #     controller: 'VehicleDeleteCtrl',
  #     resolve:
  #       vehicle: -> $scope.vehicle

  #   modalInstance.result
  #     .then ->
  #       $scope.vehicle.$delete()
  #         .then ->
  #           $location.path('/vehicles')
  #         .catch (data) ->
  #           $scope.errorMessage = data.error || 'Unknown error'
  #     .finally ->
  #       $scope.isDeleting = false
]
