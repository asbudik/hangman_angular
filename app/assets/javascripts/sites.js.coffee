# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

GameApp = angular.module("GameApp", ["ngRoute", "templates"])

GameApp.config ["$routeProvider", "$locationProvider", ($routeProvider, $locationProvider) ->
  $routeProvider
    .when '/',
      templateUrl: "index.html",
      controller: "GamesCtrl"
    .when '/games',
      templateUrl: "test.html",
      controller: "GamesCtrl"
  .otherwise
      redirectTo: "/"

      $locationProvider.html5Mode(true).hashPrefix("#")

]

GameApp.controller "GamesCtrl", ["$scope", "$http", ($scope, $http) ->
  
  
  $scope.chars = [].concat.apply([], Array(26)).map((_, i) ->
    String.fromCharCode i + 65
  )
  $scope.arrayWords = []
  $scope.words = {}

  $scope.getWord = (game) ->
    
    splitWord = game.secret.toUpperCase().split('')

    
    i = 0
    count = 0
    # console.log($scope.words[splitWord[i] + count] = "")

    while i < game.secret.length
      $scope.words[splitWord[i] + count] = ""
      $scope.arrayWords.push($scope.words)
      # console.log($scope.arrayWords)
      $scope.words = {}
      i++
      count++

    this.game = {}

  $scope.findLetter = (letter) ->
    i = 0
    # console.log("array", $scope.arrayWords['A'])
    # console.log("dsfsd", Object.keys($scope.words).length)
    while i < $scope.arrayWords.length
      console.log("array", $scope.arrayWords[i][letter + i])
      if $scope.arrayWords[i][letter + i] == ""
        $scope.arrayWords[i][letter + i] = letter
      i++

]