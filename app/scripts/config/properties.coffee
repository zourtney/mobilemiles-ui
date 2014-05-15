'use strict'

app = angular.module 'mobilemilesApp'

app.constant 'properties',
  BASE_URL: '<%= process.env.SERVER_URL %>',
  FIRST_PAGE: '/vehicles'