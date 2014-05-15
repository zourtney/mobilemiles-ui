'use strict'

app = angular.module 'mobilemilesApp'

app.factory 'Vehicle', ['$resource', 'properties', ($resource, properties) ->
  return $resource(properties.BASE_URL + '/vehicles/:id', { id: '@id' })
]