module = angular.module 'mobilemiles.users'

module.factory 'User', ['$resource', 'properties', ($resource, properties) ->
  return $resource(properties.BASE_URL + '/users/:id', {id: '@id'})
]