angular.module('scrambledApp').controller "UserTournamentController", ['$rootScope', '$scope', 'TournamentService', '$http', ($rootScope, $scope, TournamentService, $http) ->
  @service = new TournamentService()
  $scope.tournaments = @service.user()
  $scope.isViewingTournament = false

  $scope.selectedTournament = null
  $scope.beforeStartDate = false
  $scope.pickingTime = false
  $scope.showStandings = false
  $scope.standings = []
  $scope.picks = {
    agolfer: "",
    bgolfer: "",
    cgolfer: "",
    dgolfer: ""
  }
  $scope.invite = {}


  $scope.submitGolfers = (picks) ->
    data = {
      tournament_id: $scope.selectedTournament.id,
      agolfer: picks.agolfer,
      bgolfer: picks.bgolfer,
      cgolfer: picks.cgolfer,
      dgolfer: picks.dgolfer
    }
    $http.post('/tournaments/' + $scope.selectedTournament.id + '/update_invitation_with_golfers', {picks: data})



  $scope.selectTournament = (tournament) ->
    service = new TournamentService()
    $scope.pickingTime = false
    $scope.beforeStartDate = false
    $scope.showStandings = false
    $scope.selectedTournament = tournament
    $scope.isViewingTournament = true
    $scope.showStandings = true
    $http.get('/tournaments/' + $scope.selectedTournament.id + '/standings').then (data) ->
      console.log(data.data)
      $scope.standings = data.data
    date = new Date()
    if (date.isBefore(tournament.picks_start))
      $scope.beforeStartDate = true
    if (date.isBetween(tournament.picks_start, tournament.picks_end))
      $scope.invite = service.userInvite(tournament.id)
      $scope.agolfers = service.agolfers(tournament.id)
      $scope.bgolfers = service.bgolfers(tournament.id)
      $scope.cgolfers = service.cgolfers(tournament.id)
      $scope.dgolfers = service.dgolfers(tournament.id)
      $scope.pickingTime = true
    if (date.isAfter(tournament.picks_end))
      $scope.showStandings = true
      $http.get('/tournaments/' + $scope.selectedTournament.id + '/standings').then (data) ->
        $scope.standings = data.data

]
