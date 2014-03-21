scrambledApp = angular.module('scrambledApp', ['ngResource', 'ngRoute']).run(['$rootScope', ($rootScope) ->

])

scrambledApp.config (['$routeProvider', '$httpProvider', ($routeProvider, $httpProvider) ->
  $routeProvider.when('/', {templateUrl: '/templates/frontPage.html'})
  authToken = $("meta[name=\"csrf-token\"]").attr("content")
  $httpProvider.defaults.headers.common["X-CSRF-TOKEN"] = authToken
  defaults = $httpProvider.defaults.headers
  defaults.patch = defaults.patch || {}
  defaults.patch['Content-Type'] = 'application/json'
])

$(document).on 'page:load', ->
  $('[ng-app]').each ->
    module = $(this).attr('ng-app')
    angular.bootstrap(this, [module])
