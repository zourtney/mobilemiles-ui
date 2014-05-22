fillups = angular.module 'mobilemiles.fillups'

fillups.factory 'Fillup', ['$resource', 'properties', ($resource, properties) ->
  return $resource(properties.BASE_URL + '/fillups/:id', 
    { id: '@id' },
    { update: { method : 'PUT' } }
  )
]