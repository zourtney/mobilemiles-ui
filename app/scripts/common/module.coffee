# Constants
angular.module 'mobilemiles.common', []

.constant 'properties',
  BASE_URL: '<%= process.env.SERVER_URL %>',   # environment variable set via grunt
  FIRST_PAGE: '/vehicles'
  #TODO: build date/time
