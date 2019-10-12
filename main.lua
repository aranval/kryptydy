-- Inne
peachy = require("Libraries/peachy-master/peachy")
iffy = require('Libraries/iffy-master/iffy')
bump = require('Libraries/bump-master/bump')
Camera = require("Libraries/hump-master/camera")
Class = require("Libraries/hump-master/class")

require("src/functions")

-- InputManager
baton = require('Libraries/baton-master/baton')

Input = baton.new {
	controls = {
	  left = {'key:left', 'key:a', 'axis:leftx-', 'button:dpleft'},
	  right = {'key:right', 'key:d', 'axis:leftx+', 'button:dpright'},
	  up = {'key:up', 'key:w', 'axis:lefty-', 'button:dpup'},
	  down = {'key:down', 'key:s', 'axis:lefty+', 'button:dpdown'},
	  action = {'key:x', 'button:a'},
	  debug = {'key:f1'}
	},
	pairs = {
	  move = {'left', 'right', 'up', 'down'}
	},
	joystick = love.joystick.getJoysticks()[1],
  }

-- ECS
tiny = require("Libraries/tiny-ecs-master/tiny")
drawSystemFilter = tiny.requireAll("isDrawingSystem")
updateSystemFilter = tiny.rejectAll("isDrawingSystem")

-- GameStates
GameState = require("Libraries/hump-master/gamestate")
require("src/states/MenuState")
require("src/states/TestLevelState")
require("src/states/TestLevel2State")
require("src/states/BattleState")
require("src/states/GameOverState")

-- GLOBALNE
assets = {}
bumpWorld = nil
tinyWorld = tiny.world()
tileSize = 32
gotoState = nil

function love.load()
	-- Wczytywanie assetów
	assets = require("src/assets")

	-- Wczytywanie Tilesetów i tilemap
	iffy.newTileset("TestSet", "Assets/Tilemaps/test-tileset.png")
    iffy.newTilemap("TestLevel1", "Assets/Tilemaps/TestLevel_Map.csv") 
    iffy.newTilemap("TestLevel2", "Assets/Tilemaps/TestLevel2_Map.csv") 
	
	GameState.registerEvents()
	GameState.switch(MenuState)
end

function love.update(dt)
	Input:update()
end