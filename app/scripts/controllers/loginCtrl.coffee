'use strict';

app = angular.module 'mobilemilesApp'

app.controller 'LoginCtrl', ['$scope', '$rootScope', '$location', '$window', 'properties', 'User', 'Session', ($scope, $rootScope, $location, $window, properties, User, Session) ->

  # Handle 'enter'-key submission from the form (since we can't reliably use
  # the default "first button is the submit button" with all the hiding logic.)
  $scope.onSubmit = ->
    if $scope.registerMode then $scope.register() else $scope.logIn()

  # Attempt to log the user in.
  $scope.logIn = ->
    $scope.isBusy = true

    session = new Session()
    session.email = $scope.email
    session.password = $scope.password

    session.$save()
      .then (data) ->
        $window.localStorage.token = data.token;
        $rootScope.session = data.session
        $rootScope.user = data.user
        $location.path(properties.FIRST_PAGE)
      .catch (data) ->
        delete $window.localStorage.token;
        $scope.error = data.data.error
      .finally -> $scope.isBusy = false

  # Attempt to register a new user with the given email and password. If it
  # succeeds, log them in.
  $scope.register = ->
    if $scope.password != $scope.passwordConfirm
      return $scope.error = 'Passwords do not match';

    $scope.isBusy = true

    user = new User();
    user.user =
      email: $scope.email,
      password: $scope.password

    user.$save()
      .then (data) ->
        $scope.logIn()
      .catch -> $scope.error = 'Unknown error occurred while registering.'
      .finally -> $scope.isBusy = false
]