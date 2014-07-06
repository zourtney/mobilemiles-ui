angular.module 'mobilemiles.auth'

.controller 'LoginCtrl', ['$scope', '$rootScope', '$location', 'properties', 'User', 'Session', ($scope, $rootScope, $location, properties, User, Session) ->

  $rootScope.isFullscreen = true;

  doLogIn = (email, password) ->
    $scope.isBusy = true

    Session.create(email, password)
      .then (data) ->
        $location.path(properties.FIRST_PAGE)
      .catch (data) ->
        $scope.error = data.error || 'Unable to connect to server'
      .finally ->
        $scope.isBusy = false

  # Handle 'enter'-key submission from the form (since we can't reliably use
  # the default "first button is the submit button" with all the hiding logic.)
  $scope.onSubmit = ->
    if $scope.registerMode then $scope.register() else $scope.logIn()

  # Attempt to log the user in.
  $scope.logIn = ->
    doLogIn($scope.email, $scope.password)

  $scope.logInAsGuest = ->
    doLogIn('guest@example.com', 'guest123')

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
      .catch ->
        $scope.error = 'Unknown error occurred while registering.'
      .finally ->
        $scope.isBusy = false

]