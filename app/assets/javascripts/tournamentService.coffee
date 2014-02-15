angular.module('scrambledApp').factory 'TournamentService', ['$resource', '$http', ($resource, $http) ->
  class TournamentService
    constructor: (errorHandler) ->
      @service = $resource('/tournaments/:verb', {verb:'previous'})
      @errorHandler = errorHandler
      defaults = $http.defaults.headers

    all: ->
      @service.query((-> null), @errorHandler)
    upcoming: ->
      @service.query({verb:'upcoming'}, (-> null), @errorHandler)
    user: ->
      @service.query({verb:'user_tournaments'}, (-> null), @errorHandler)

]