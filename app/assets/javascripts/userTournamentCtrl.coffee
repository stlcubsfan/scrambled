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
    $http.post('/tournaments/' + $scope.selectedTournament.id + '/update_invitation_with_golfers', {picks: data}).success (data, status) ->
      $scope.message = "Your picks have been saved successfully!"



  $scope.selectTournament = (tournament) ->
    service = new TournamentService()
    $scope.pickingTime = false
    $scope.beforeStartDate = false
    $scope.showStandings = false
    $scope.message = ''
    $scope.selectedTournament = tournament
    $scope.isViewingTournament = true
    date = new Date()
    if (date.isBefore(tournament.picks_start))
      $scope.beforeStartDate = true
    if (date.isBetween(tournament.picks_start, tournament.picks_end))
      $http.get('/tournaments/' + $scope.selectedTournament.id + '/user_tournament_invitation').then (data) ->
        $scope.invite = data.data
      $http.get('/tournaments/' + $scope.selectedTournament.id + '/agolfers').then (data) ->
        $scope.agolfers = data.data
      $http.get('/tournaments/' + $scope.selectedTournament.id + '/bgolfers').then (data) ->
        $scope.bgolfers = data.data
      $http.get('/tournaments/' + $scope.selectedTournament.id + '/cgolfers').then (data) ->
        $scope.cgolfers = data.data
      $http.get('/tournaments/' + $scope.selectedTournament.id + '/dgolfers').then (data) ->
        $scope.dgolfers = data.data				
      $scope.pickingTime = true
    if (date.isAfter(tournament.picks_end))
      $scope.showStandings = true
      $http.get('/tournaments/' + $scope.selectedTournament.id + '/standings').then (data) ->
        $scope.standings = data.data

]
