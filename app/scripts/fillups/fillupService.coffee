fillups = angular.module 'mobilemiles.fillups'

fillups.factory 'Fillups', ['$resource', 'properties', ($resource, properties) ->
  return $resource(properties.BASE_URL + '/fillups/:id', 
      { id: '@id' },
      { update: { method : 'PUT' } }
  )
]