'use strict';

describe('Auth token', function() {
  var authToken;

  beforeEach(module('mobilemiles.auth'));

  beforeEach(inject(['authToken', function(a) {
    authToken = a;
  }]));

  it('should exist', function() {
    expect(authToken).toBeDefined();
  });

  it('should have an isAuthorized function', function() {
    expect(authToken.isAuthorized).toBeDefined();
  });

  it('should have an create function', function() {
    expect(authToken.create).toBeDefined();
  });

  it('should have an destroy function', function() {
    expect(authToken.destroy).toBeDefined();
  });

  it('should have an getBearerToken function', function() {
    expect(authToken.getBearerToken).toBeDefined();
  });

  //TODO: test read / write functionality
});
