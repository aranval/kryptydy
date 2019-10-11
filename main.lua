-- Inne
peachy = require("Libraries/peachy-master/peachy")
iffy = require('Libraries/iffy-master/iffy')
Camera = require("Libraries/hump-master/camera")

-- InputManager
baton = require('Libraries/baton-master/baton')

Input = baton.new {
	controls = {
	  left = {'key:left', 'key:a', 'axis:leftx-', 'button:dpleft'},
	  right = {'key:right', 'key:d', 'axis:leftx+', 'button:dpright'},
	  up = {'key:up', 'key:w', 'axis:lefty-', 'button:dpup'},
	  down = {'key:down', 'key:s', 'axis:lefty+', 'button:dpdown'},
	  action = {'key:x', 'button:a'},
	},
	pairs = {
	  move = {'left', 'right', 'up', 'down'}
	},
	joystick = love.joystick.getJoysticks()[1],
  }

-- ECS
Class = require("Libraries/hump-master/class")
tiny = require("Libraries/tiny-ecs-master/tiny")
drawSystemFilter = tiny.requireAll("isDrawingSystem")
updateSystemFilter = tiny.rejectAll("isDrawingSystem")

-- GameStates
GameState = require("Libraries/hump-master/gamestate")
require("src/states/MenuState")
require("src/states/TestLevelState")
require("src/states/BattleState")
require("src/states/GameOverState")

-- GLOBALNE
assets = {}

function love.load()
	-- Wczytywanie assetów
	assets = require("src/assets")

	-- Wczytywanie Tilesetów i tilemap
	iffy.newTileset("Testset", "Assets/Tilemaps/TestTile.png")
    iffy.newTilemap("Testmap", "Assets/Tilemaps/TestMap.csv") 
	
	GameState.registerEvents()
	GameState.switch(TestLevelState)
end

function love.update(dt)
	Input:update()
end