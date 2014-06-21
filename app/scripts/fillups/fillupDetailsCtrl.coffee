module = angular.module 'mobilemiles.fillups'

module.controller 'FillupDetailsCtrl', ['$scope', '$modal', '$location', 'Geolocation', 'GasStation', 'Grade', 'Vehicle', 'Fillup', 'fillupId', ($scope, $modal, $location, Geolocation, GasStation, Grade, Vehicle, Fillup,  fillupId) ->

  $scope.isSettingTime = false
  $scope.vehicles = Vehicle.query()
  $scope.grades = Grade.query()


  # Handle Bootstrap UI alert close events
  $scope.alerts = []
  $scope.closeAlert = (index) ->
    $scope.alerts.splice(index, 1)
  

  # Fetch the existing fillup, or make a new empty one
  if fillupId == 'new'
    $scope.isNew = true
    $scope.fillup = new Fillup()
    $scope.autoCalcPrice = true
  else
    Fillup.get({ id: fillupId }).$promise
      .then (data) ->
        $scope.fillup = data
        $scope.autoCalcPrice = $scope.fillup.price == getAutoCalcPrice()
      .catch (data) ->
        $scope.fillup = null

  # When the fillup AND vehicles list are present, set `$scope.vehicle`. Note
  # that `$scope.vehicle` is a reference to an item in the `$scope.vehicles`
  # list. This is necessary for the dropdown to select the proper item.
  $scope.$watchCollection '[fillup, vehicles]', ->
    if $scope.fillup and $scope.vehicles
      $scope.vehicle = _.find($scope.vehicles, {id: $scope.fillup.vehicle_id})


  # Convenience function for telling the state of in-progress AJAX requests
  $scope.isBusy = ->
    return $scope.isSaving || $scope.isDeleting || $scope.isSettingTime


  # Auto-calculate the price (round to 2 decimal places)
  getAutoCalcPrice = ->
    Math.ceil($scope.fillup.gallons * $scope.fillup.price_per_gallon * 100) / 100

  $scope.updatePrice = ->
    if $scope.autoCalcPrice
      $scope.fillup.price = getAutoCalcPrice()


  # Create or update the resource on the server
  $scope.save = ->
    if not $scope.vehicle
      $scope.alerts.push
        type: 'warning',
        msg: 'You must select a vehicle.'
    else
      $scope.isSaving = true
      $scope.fillup.vehicle_id = $scope.vehicle.id
      method = if $scope.isNew then '$save' else '$update'

      $scope.fillup[method]()
        .then ->
          if $scope.isNew
            $location.path('/fillups/' + $scope.fillup.id)
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
      templateUrl: 'views/fillups/fillupDelete.html',
      controller: 'FillupDeleteCtrl',
      resolve:
        fillup: -> $scope.fillup

    modalInstance.result
      .then ->
        $scope.fillup.$delete()
          .then ->
            $location.path('/fillups')
          .catch (data) ->
            $scope.alerts.push
              type: 'danger',
              msg: data.error || 'Unknown error'
      .finally ->
        $scope.isDeleting = false


  # Show the "change time" modal
  $scope.changeTime = ->
    modalInstance = $modal.open
      templateUrl: 'views/fillups/fillupChangeTime.html',
      controller: 'FillupChangeTimeCtrl',
      resolve:
        fillup: -> $scope.fillup

    modalInstance.result.then (newTimestamp) ->
      $scope.fillup.completed_at = newTimestamp
      if not $scope.isNew
        $scope.isSaving = true
        $scope.fillup.$update()
          .then ->
            $scope.isNew = false
          .catch (data) ->
            $scope.alerts.push
              type: 'danger',
              msg: data.error || 'Unknown error'
          .finally ->
            $scope.isSaving = false


  # Query google for nearby gas stations
  $scope.map = {
    control: {},
    center: {
      latitude: 35.5348213,
      longitude: -83.587697
    },
    zoom: 8
  }

  $scope.$watch 'geoCoords', ->
    $scope.map.center.latitude = $scope.geoCoords.latitude
    $scope.map.center.longitude = $scope.geoCoords.longitude

  Geolocation.get()
    .then (location) ->
      $scope.geoCoords = _.pick(location.coords, 'latitude', 'longitude')

      GasStation.nearby($scope.map.control.getGMap(), $scope.geoCoords)
        .then (results) ->
          $scope.nearestStation = results[0] or {}
        .catch (error) ->
          $scope.alerts.push
            type: 'warning'
            msg: error
    .catch (error) ->
      $scope.alerts.push
        type: 'warning',
        msg: error.message

]
