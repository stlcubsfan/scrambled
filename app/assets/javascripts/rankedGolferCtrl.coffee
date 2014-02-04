angular.module('scrambledApp').controller "RankedGolferController", ['$rootScope', '$scope', 'RankedGolferService', ($rootScope, $scope, RankedGolferService) ->
  $scope.rankedGolfers = []
  RankedGolferService.getCurrentRankings().then (data) ->
    $scope.rankedGolfers = data
]