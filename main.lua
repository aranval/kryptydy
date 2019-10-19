-- GLOBALNE
libs = require("src/libs")

classes = require("src/classes")
states = require("src/states")
CONST = require("src/constants")

bumpWorld = nil
tinyWorld = libs.tiny.world()
tilemaps = {}
switchToLevel = nil

gameEvents = {}

require("src/functions")

-- InputManager
Input = libs.baton.new {
	controls = {
	  left = {'key:left', 'key:a', 'axis:leftx-', 'button:dpleft'},
	  right = {'key:right', 'key:d', 'axis:leftx+', 'button:dpright'},
	  up = {'key:up', 'key:w', 'axis:lefty-', 'button:dpup'},
	  down = {'key:down', 'key:s', 'axis:lefty+', 'button:dpdown'},
	  action = {'key:x', 'button:a'},
	  f1 = {'key:f1'},
	  f2 = {'key:f2'}
	},
	pairs = {
	  move = {'left', 'right', 'up', 'down'}
	},
	joystick = love.joystick.getJoysticks()[1],
  }

-- ECS Filters
drawSystemFilter = libs.tiny.requireAll("isDrawingSystem")
updateSystemFilter = libs.tiny.rejectAll("isDrawingSystem")

function love.load()
	love.graphics.setDefaultFilter("nearest", "nearest")

	-- Pierwszy poziom
	switchToLevel = "TestLevel"

	-- Story
	gameEvents = doFile("Assets/Story/GameEvents.txt")

	-- iffy Init Wczytywanie Tilesetów i tilemap
	libs.iffy.newTileset("test", "Assets/Levels/Tilesets/test.png")
    tilemaps.TestLevel = libs.iffy.newTilemap("TestLevel", "Assets/Levels/TestLevel_Map.csv")
	
	libs.gameState.registerEvents()
	libs.gameState.switch(states.menu)
end

function love.update(dt)
	Input:update()
	libs.talkies.update(dt)
end