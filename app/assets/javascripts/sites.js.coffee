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
  $scope.secret = ""
  $scope.count = 0
  $scope.guesses = 6
  $scope.singleCheck = {}
  $scope.revertLetterHide = []
  $scope.objWinKeys = []
  $scope.hints = {}
  $scope.newHint = []
  $scope.hintcount = 0

  j = 0
  while j < 6
    $scope.singleCheck["checked#{j}"] = false
    console.log($scope.singleCheck)
    j++

  $scope.getWord = (game, hint) ->
    $scope.hints = hint
    console.log($scope.hints)
    $scope.secret = game
    $scope.formsubmit = true
    $scope.play = true
    if $scope.hints != undefined
      $scope.hintbutton = true
    # console.log("word", $scope.secret)
    
    splitWord = game.secret.toUpperCase().split('')
    
    i = 0
    count = 0

    while i < game.secret.length
      $scope.words[splitWord[i] + count] = ""
      $scope.objWinKeys.push(splitWord[i] + count)
      $scope.arrayWords.push($scope.words)
      $scope.words = {}
      i++
      count++

    this.game = {}
    $scope.dismiss = "modal"

  $scope.showHint = () ->
    $scope.newHint.push($scope.hints[$scope.hintcount])
    $scope.hintcount += 1
    if $scope.newHint.length == Object.keys($scope.hints).length
      $scope.hintbutton = false




  $scope.findLetter = (letter) ->
    $scope.wrongGuess = true
    if $scope.secret == "" || $scope.guesses == 0
      letter.preventDefault()
    else
      $scope.revertLetterHide.push(this)
      i = 0
      while i < $scope.arrayWords.length
        this.hideLetter = true
        if $scope.arrayWords[i][letter + i] == ""
          $scope.arrayWords[i][letter + i] = letter
          $scope.wrongGuess = false
        i++

      if $scope.wrongGuess == true
        $scope.singleCheck["checked" + $scope.count] = true
        # console.log($scope.singleCheck)
        $scope.count += 1
        $scope.guesses -= 1
        if $scope.guesses == 0
          # console.log($scope.secret)
          $scope.gameover = true
          $scope.hintbutton = false
          $scope.notice = "Sorry, the answer was '#{$scope.secret.secret.toUpperCase()}'"
          $scope.replay = true

      win = true
      count = 0
      for i in $scope.arrayWords
        console.log(i[$scope.objWinKeys[count]])
        if i[$scope.objWinKeys[count]] == ""
          win = false
        count++

      if win == true
        $scope.guesses = 0
        $scope.gameover = true
        $scope.hintbutton = false
        $scope.notice = "You have won! Congratulations!"
        $scope.replay = true

  $scope.refresh = () ->
    $scope.arrayWords = []
    $scope.words = {}
    $scope.secret = ""
    $scope.singleCheck = {}
    $scope.guesses = 6
    $scope.count = 0
    $scope.replay = false
    $scope.notice = ""
    $scope.play = false
    $scope.gameover = false
    $scope.formsubmit = false
    $scope.hideLetter = false
    $scope.newHint = []
    $scope.hintcount = 0
    $scope.hintbutton = false


    for i in $scope.revertLetterHide
      i.hideLetter = false

    $scope.revertLetterHide = []




]