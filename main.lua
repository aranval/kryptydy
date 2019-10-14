-- GLOBALNE
libs = require("src/libs")

classes = require("src/classes")
entities = require("src/entities")
states = require("src/states")
systems = require("src/systems")

cameraSpeed = 3.1
assets = {}
bumpWorld = nil
tinyWorld = libs.tiny.world()
tileSize = 32
gotoState = nil
-- Debug
camCenterDebug = false
drawDebug = false

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
	-- Wczytywanie assetów
	assets = require("src/assets")

	-- Wczytywanie Tilesetów i tilemap
	libs.iffy.newTileset("TestSet", "Assets/Tilemaps/test-tileset.png")
    libs.iffy.newTilemap("TestLevel1", "Assets/Tilemaps/TestLevel_Map.csv") 
    libs.iffy.newTilemap("TestLevel2", "Assets/Tilemaps/TestLevel2_Map.csv") 
	
	libs.gameState.registerEvents()
	libs.gameState.switch(states.menu)
end

function love.update(dt)
	Input:update()

	if(Input:pressed("f1")) then 
        if drawDebug then drawDebug = false
        elseif not drawDebug then drawDebug = true end
	end
	if(Input:pressed("f2")) then 
        if camCenterDebug then camCenterDebug = false
        elseif not camCenterDebug then camCenterDebug = true end
    end
end