module = angular.module 'mobilemiles.vehicles'

module.factory 'Vehicle', ['$resource', 'properties', ($resource, properties) ->
  return $resource(properties.BASE_URL + '/vehicles/:id', 
    { id: '@id' },
    { update: { method : 'PUT' } }
  )
]