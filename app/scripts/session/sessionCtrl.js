'use strict';

angular.module('mobilemilesApp')
  .factory('Session', ['$resource', 'properties', function($resource, properties) {
    return $resource(properties.BASE_URL + '/session/');
  }]);