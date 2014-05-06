'use strict'

app = angular.modular 'mobilemilesApp'

app.factory 'Vehicle', [$resource, 'properties'], ($resource, properties) ->
  return $resource(properties.BASE_URL + '/vehicles/:id', { id: '@id' })
]