angular.module('scrambledApp').factory "EspnService", ["$http", "$q", ($http, $q) ->
  getNews = ->
    deferred = $q.defer()
    httpCall = $http.jsonp("http://api.espn.com/v1/sports/golf/news?limit=10&apiKey=hw5fm9jjv87w9h54ar5v9rj9&callback=JSON_CALLBACK");
    httpCall.success (data) ->
      deferred.resolve data

    deferred.promise

  {
    getNews: getNews
  }
]