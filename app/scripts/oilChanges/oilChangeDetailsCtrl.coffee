angular.module 'mobilemiles.oilChanges'

.controller 'OilChangeDetailsCtrl', ['$scope', '$modal', '$location', 'Vehicle', 'OilChange', 'oilChangeId', ($scope, $modal, $location, Vehicle, OilChange, oilChangeId) ->

  $scope.isSettingTime = false
  $scope.vehicles = Vehicle.query()


  # Handle Bootstrap UI alert close events
  $scope.alerts = []
  $scope.closeAlert = (index) ->
    $scope.alerts.splice(index, 1)


  if oilChangeId == 'new'
    # Create a new oil change object, initialized with current position.
    $scope.isNew = true
    $scope.oilChange = new OilChange()
  else
    # Fetch the existing fillup.
    OilChange.get({ id: oilChangeId }).$promise
      .then (data) ->
        $scope.oilChange = data
      .catch (data) ->
        $scope.oilChange = null

  # When the oil change AND vehicles list are present, set `$scope.vehicle`.
  # Note that `$scope.vehicle` is a reference to an item in the
  # `$scope.vehicles` list. This is necessary for the dropdown to select the
  # proper item.
  $scope.$watchCollection '[oilChange, vehicles]', ->
    if $scope.oilChange and $scope.vehicles
      $scope.vehicle = _.find($scope.vehicles, {id: $scope.oilChange.vehicle_id})


  # Convenience function for telling the state of in-progress AJAX requests
  $scope.isBusy = ->
    return $scope.isSaving || $scope.isDeleting || $scope.isSettingTime


  # Create or update the resource on the server
  $scope.save = ->
    if not $scope.vehicle
      $scope.alerts.push
        type: 'warning',
        msg: 'You must select a vehicle.'
    else
      $scope.isSaving = true
      method = if $scope.isNew then '$save' else '$update'

      $scope.oilChange[method]()
        .then ->
          if $scope.isNew
            $location.path('/oilChanges/' + $scope.oilChange.id)
          $scope.isNew = false
        .catch (data) ->
          $scope.alerts.push
            type: 'danger',
            msg: data.error || 'Unknown error'
        .finally ->
          $scope.isSaving = false


  # Show the "delete" modal
  $scope.delete = ->
    $scope.isDeleting = true

    modalInstance = $modal.open
      templateUrl: 'views/oilChange/oilChangeDelete.html',
      controller: 'OilChangeDeleteCtrl',
      resolve:
        oilChange: -> $scope.oilChange

    modalInstance.result
      .then ->
        $scope.oilChange.$delete()
          .then ->
            $location.path('/oilChanges')
          .catch (data) ->
            $scope.alerts.push
              type: 'danger',
              msg: data.error || 'Unknown error'
      .finally ->
        $scope.isDeleting = false


  # Show the "change time" modal
  $scope.changeTime = ->
    modalInstance = $modal.open
      templateUrl: 'views/oilChange/oilChangeChangeTime.html',
      controller: 'oilChangeChangeTimeCtrl',
      resolve:
        oilChange: -> $scope.oilChange

    modalInstance.result.then (newTimestamp) ->
      $scope.oilChange.completed_at = newTimestamp
      if not $scope.isNew
        $scope.isSaving = true
        $scope.oilChange.$update()
          .then ->
            $scope.isNew = false
          .catch (data) ->
            $scope.alerts.push
              type: 'danger',
              msg: data.error || 'Unknown error'
          .finally ->
            $scope.isSaving = false

  # Keep `oilChange.vehicle_id` in sync with the currently selected one from
  # the dropdown.
  $scope.$watch 'vehicle', () ->
    if $scope.vehicle
      $scope.oilChange.vehicle_id = $scope.vehicle.id

]
