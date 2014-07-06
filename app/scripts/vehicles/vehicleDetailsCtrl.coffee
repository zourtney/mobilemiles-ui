angular.module 'mobilemiles.vehicles'

.controller 'VehicleDetailsCtrl', ['$scope', '$modal', '$location', 'Vehicle', 'vehicleId', ($scope, $modal, $location, Vehicle, vehicleId) ->
  
  # Fetch the existing vehicle, or make a new empty one
  if vehicleId == 'new'
    $scope.isNew = true
    $scope.vehicle = new Vehicle()
  else
    Vehicle.get({ id: vehicleId }).$promise
      .then (data) ->
        $scope.vehicle = data
      .catch (data) ->
        $scope.vehicle = null

  # Convenience function for telling the state of in-progress AJAX requests
  $scope.isBusy = ->
    return $scope.isSaving || $scope.isDeleting

  # Create or update the resource on the server
  $scope.save = ->
    $scope.isSaving = true
    method = if $scope.isNew then '$save' else '$update' 

    $scope.vehicle[method]()
      .then ->
        if $scope.isNew
          $location.path('/vehicles/' + $scope.vehicle.id)
        $scope.isNew = false
      .catch (data) ->
        $scope.errorMessage = data.error || 'Unknown error'
      .finally ->
        $scope.isSaving = false

  # Delete the resource :'( On success, redirect to list page
  $scope.delete = ->
    $scope.isDeleting = true

    modalInstance = $modal.open
      templateUrl: 'views/vehicles/vehicleDelete.html',
      controller: 'VehicleDeleteCtrl',
      resolve:
        vehicle: -> $scope.vehicle

    modalInstance.result
      .then ->
        $scope.vehicle.$delete()
          .then ->
            $location.path('/vehicles')
          .catch (data) ->
            $scope.errorMessage = data.error || 'Unknown error'
      .finally ->
        $scope.isDeleting = false
]
