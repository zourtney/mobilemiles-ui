module = angular.module 'mobilemiles.fillups'

module.factory 'Fillup', ['$resource', 'properties', ($resource, properties) ->
  return $resource(properties.BASE_URL + '/fillups/:id', 
    { id: '@id' },
    { update: { method : 'PUT' } }
  )
]

module.factory 'Grades', ->
  query = -> [
    { name: 'Regular', val: 'regular' },
    { name: 'Plus', val: 'plus' },
    { name: 'Premium', val: 'premium' }
  ]

  get = (val) ->
    return (i for i in query() when i.val is val)[0]

  return {
    query: query
    get: get
  }