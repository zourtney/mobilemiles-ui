module = angular.module 'mobilemiles.fillups'

module.controller 'FillupDetailsCtrl', ['$scope', '$modal', '$location', 'Grade', 'Vehicle', 'Fillup', 'fillupId', ($scope, $modal, $location, Grade, Vehicle, Fillup,  fillupId) ->

  $scope.isSettingTime = false
  $scope.vehicles = Vehicle.query()
  $scope.grades = Grade.query()
  
  # Fetch the existing vehicle, or make a new empty one
  if fillupId == 'new'
    $scope.isNew = true
    $scope.fillup = new Fillup()
    $scope.autoCalcPrice = true
  else
    Fillup.get({ id: fillupId }).$promise
      .then (data) ->
        $scope.fillup = data
        $scope.vehicle = Vehicle.get({ id: data.vehicle_id })
        $scope.autoCalcPrice = $scope.fillup.price == getAutoCalcPrice()
      .catch (data) ->
        $scope.fillup = null


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
    $scope.isSaving = true
    $scope.fillup.vehicle_id = $scope.vehicle.id
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
            $scope.errorMessage = data.error || 'Unknown error'
      .finally ->
        $scope.isDeleting = false


  # Show the "change time" modal
  $scope.changeTime = ->
    modalInstance = $modal.open
      templateUrl: 'views/fillups/fillupChangeTime.html',
      controller: 'FillupChangeTimeCtrl',
      resolve:
        fillup: -> $scope.fillup

    modalInstance.result
      .then ->
        $scope.isSaving = true
        $scope.fillup.$update()
          .then ->
            $scope.isNew = false
          .catch (data) ->
            $scope.errorMessage = data.error || 'Unknown error'
          .finally ->
            $scope.isSaving = false

]
