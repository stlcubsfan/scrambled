angular.module('scrambledApp').factory 'RankedGolferService', ['$http', '$q', ($http, $q) ->
  getCurrent = ->
    deferred = $q.defer()
    httpCall = $http.get("ranked_golfers.json")
    httpCall.success (data) ->
      deferred.resolve data

    deferred.promise

  {
    getCurrentRankings: getCurrent
  }
]