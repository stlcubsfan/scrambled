angular.module('scrambledApp').factory 'TournamentService', ['$resource', '$http', ($resource, $http) ->
  class TournamentService
    constructor: (errorHandler) ->
      @service = $resource('/tournaments/:id/:verb', {verb:'previous'})
      @errorHandler = errorHandler
      defaults = $http.defaults.headers

    all: ->
      @service.query((-> null), @errorHandler)
    upcoming: ->
      @service.query({verb:'upcoming'}, (-> null), @errorHandler)
    user: ->
      @service.query({verb:'user_tournaments'}, (-> null), @errorHandler)
    agolfers: (id) ->
      @service.query({id: id, verb:'agolfers'}, (-> null), @errorHandler)
    bgolfers: (id) ->
      @service.query({id: id, verb:'bgolfers'}, (-> null), @errorHandler)
    cgolfers: (id) ->
      @service.query({id: id, verb:'cgolfers'}, (-> null), @errorHandler)
    dgolfers: (id) ->
      @service.query({id: id, verb:'dgolfers'}, (-> null), @errorHandler)
    userInvite: (id) ->
      @service.get({id: id, verb:'user_tournament_invitation'}, (-> null), @errorHandler)
]