'use strict';

angular.module('mobilemilesApp')
  .factory('Users', ['$resource', 'properties', function($resource, properties) {
    return $resource(properties.BASE_URL + '/users/:id', {id: '@id'});
  }]);