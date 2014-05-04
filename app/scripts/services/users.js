'use strict';

angular.module('mobilemilesApp')
  .factory('User', ['$resource', 'properties', function($resource, properties) {
    return $resource(properties.BASE_URL + '/users/:id', {id: '@id'});
  }]);