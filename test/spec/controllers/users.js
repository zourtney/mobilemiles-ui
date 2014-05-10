'use strict';

describe('Controller: LoginCtrl', function () {

  // load the controller's module
  beforeEach(module('mobilemilesApp'));

  var LoginCtrl,
      scope;

  // Initialize the controller and a mock scope
  beforeEach(inject(function ($controller, $rootScope) {
    scope = $rootScope.$new();
    LoginCtrl = $controller('LoginCtrl', {
      $scope: scope
    });
  }));

  it('should provide a logIn() function', function () {
    expect(LoginCtrl.logIn);
  });

  it('should provide a register() function', function () {
    expect(LoginCtrl.register);
  });
});
