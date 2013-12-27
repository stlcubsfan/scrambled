angular.module('scrambledApp').controller "UpcomingTournamentsListController", ($rootScope, $scope, TournamentService) ->
  @service = new TournamentService()
  $scope.tournaments = @service.upcoming()
  $scope.previous = @service.all()
