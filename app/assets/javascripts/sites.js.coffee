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
  # $scope.arrayWords = []
  $scope.words = {}

  $scope.getWord = (game) ->
    
    splitWord = game.secret.toUpperCase().split('')

    
    i = 0
    count = 0
    while i < game.secret.length
      $scope.words[splitWord[i] + count] = ""
      console.log($scope.words)
      i++
      count++

    this.game = {}

  $scope.findLetter = (letter) ->
    i = 0
    # console.log("array", $scope.arrayWords['A'])
    # console.log("dsfsd", Object.keys($scope.words).length)
    while i < Object.keys($scope.words).length
      console.log("pandababies", $scope.words["#{letter}#{i}"])
      if $scope.words["#{letter}#{i}"] == ""
        $scope.words["#{letter}#{i}"] = letter
        console.log($scope.words)

      i++

]