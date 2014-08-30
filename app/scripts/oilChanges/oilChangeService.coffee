angular.module 'mobilemiles.oilChanges'

.factory 'OilChange', ['$resource', 'properties', ($resource, properties) ->
  return $resource(properties.BASE_URL + '/oil_changes/:id', 
    { id: '@id' },
    { update: { method : 'PUT' } }
  )
]