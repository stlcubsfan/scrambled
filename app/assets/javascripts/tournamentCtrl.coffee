angular.module('scrambledApp').controller "UpcomingTournamentsListController", ['$rootScope', '$scope', 'TournamentService', ($rootScope, $scope, TournamentService) ->
  @service = new TournamentService()
  $scope.tournaments = @service.upcoming()
]