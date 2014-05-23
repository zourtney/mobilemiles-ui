# Constants
module = angular.module 'mobilemiles.common', []

module.constant 'properties',
  BASE_URL: '<%= process.env.SERVER_URL %>',   # environment variable set via grunt
  FIRST_PAGE: '/vehicles'