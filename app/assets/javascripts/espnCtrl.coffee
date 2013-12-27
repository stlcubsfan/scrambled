angular.module('scrambledApp').controller "EspnNewsController", ['$rootScope', '$scope', 'EspnService', ($rootScope, $scope, EspnService) ->
  $scope.headlines = []
  EspnService.getNews().then (data) ->
    $scope.headlines = data.headlines

]