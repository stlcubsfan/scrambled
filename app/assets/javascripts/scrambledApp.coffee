scrambledApp = angular.module('scrambledApp', ['ngResource', 'ngRoute', 'ui.router']).run(['$rootScope', '$state', '$stateParams', ($rootScope, $state, $stateParams) ->
  $rootScope.$state = $state
  $rootScope.$stateParams = $stateParams
])

scrambledApp.config (['$stateProvider', '$urlRouterProvider', '$httpProvider', ($stateProvider, $urlRouterProvider, $httpProvider) ->
  $urlRouterProvider.when "", "/"
  $stateProvider.state 'index', {
    url: "/",
    views: {
      "upcomingTournaments": {
        templateUrl: "/templates/upcomingTournaments.html",
        controller: "UpcomingTournamentsListController"
      }, "espnHeadlines": {
        templateUrl: "/templates/espnHeadlines.html",
        controller: "EspnNewsController"
      }
    }
  }
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
