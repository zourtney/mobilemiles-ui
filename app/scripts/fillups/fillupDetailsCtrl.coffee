angular.module 'mobilemiles.fillups'

.controller 'FillupDetailsCtrl', ['$scope', '$modal', '$location', 'Geolocation', 'GasStation', 'Grade', 'Vehicle', 'Fillup', 'fillupId', ($scope, $modal, $location, Geolocation, GasStation, Grade, Vehicle, Fillup,  fillupId) ->

  $scope.isSettingTime = false
  $scope.vehicles = Vehicle.query()
  $scope.grades = Grade.query()


  # Handle Bootstrap UI alert close events
  $scope.alerts = []
  $scope.closeAlert = (index) ->
    $scope.alerts.splice(index, 1)



  $scope.mapMetadata =
    control: {}
    zoom: 8
    center:
      latitude: 35.5348213   # somewhere cool looking
      longitude: -83.587697



  # Fetch geolocation
  setLocation = () ->
    Geolocation.get()
      .then (location) ->
        $scope.fillup.latitude = location.coords.latitude
        $scope.fillup.longitude = location.coords.longitude
        getNearbyStations()
      .catch (error) ->
        $scope.alerts.push
          type: 'warning',
          msg: error.message

  getNearbyStations = () ->
    GasStation.nearby($scope.mapMetadata.control.getGMap(), $scope.fillup.latitude, $scope.fillup.longitude)
      .then (results) ->
        $scope.stations = results
        if $scope.isNew and results.length
          $scope.fillup.google_place = results[0].reference
          $scope.selectedStation = results[0]
      .catch (error) ->
        $scope.alerts.push
          type: 'warning'
          msg: error

  getOneStation = () ->
    if $scope.fillup.google_place
      GasStation.getDetails($scope.mapMetadata.control.getGMap(), $scope.fillup.google_place)
        .then (data) ->
          $scope.stations = [data]
          $scope.selectedStation = $scope.stations[0]
        .catch (error) ->
          $scope.alerts.push
            type: 'warning'
            msg: error
    else
      $scope.alerts.push
        type: 'info'
        msg: 'Gas station not recorded. No worries, you can still set it using the "When and where" section whenever you want.'

  

  if fillupId == 'new'
    # Create a new fillup object, initialized with current position.
    $scope.isNew = true
    $scope.fillup = new Fillup()
    $scope.autoCalcPrice = true 
    setLocation()
  else
    # Fetch the existing fillup.
    Fillup.get({ id: fillupId }).$promise
      .then (data) ->
        $scope.fillup = data
        $scope.autoCalcPrice = $scope.fillup.price == getAutoCalcPrice()
        getOneStation()
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
      # $scope.fillup.vehicle_id = $scope.vehicle.id
      # $scope.fillup.google_place = if $scope.selectedStation then $scope.selectedStation.reference else null
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

  $scope.changeLocation = ->
    modalInstance = $modal.open
      templateUrl: 'views/fillups/fillupChangeLocation.html',
      controller: 'FillupChangeLocationCtrl',
      resolve:
        mapMetadata: -> $scope.mapMetadata,
        stations: -> $scope.stations,
        selectedStation: -> $scope.selectedStation

    modalInstance.result.then (station) ->
      debugger
      $scope.selectedStation = station

  # Keep `fillup.vehicle_id` in sync with the currently selected one from the
  # dropdown.
  $scope.$watch 'vehicle', () ->
    if $scope.vehicle
      $scope.fillup.vehicle_id = $scope.vehicle.id

  # Keep `fillup.google_place` in sync with the currently selected one from the
  # map / station selection UIs.
  $scope.$watch 'selectedStation', () ->
    if $scope.selectedStation
      # Get additional information about this place. We could use this to 
      # display fancy stuff, but its main purpose is to get an updated version
      # of the 'reference' ID. This satisfies Google's recommendentation 
      # periodically update these references. See:
      # https://developers.google.com/maps/documentation/javascript/places#place_details_responses
      GasStation.getDetails($scope.mapMetadata.control.getGMap(), $scope.selectedStation.reference)
        .then (data) ->
          $scope.fillup.google_place = data.reference
        .catch (error) ->
          $scope.fillup.google_place = $scope.selectedStation.reference
          $scope.alerts.push
            type: 'warning'
            msg: error

]
