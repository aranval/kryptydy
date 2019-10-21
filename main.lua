-- GLOBALNE
libs = require("src/libs")

classes = require("src/classes")
states = require("src/states")
CONST = require("src/constants")

bumpWorld = nil
tinyWorld = libs.tiny.world()
tilemaps = {}
switchToLevel = nil
inventory = nil

gameEvents = {}
items = {}


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

	-- globalne inventory
	inventory = classes.inventory()
	
	-- Wczytywanie
	gameEvents = doFile("Assets/Story/GameEvents.txt")
	local itemsArray = doFile("Assets/Items.txt")
	for key, value in pairs(itemsArray) do
		items[key] = classes.item(value[1], value[2], value[3])
	end

	libs.iffy.newAtlas("Assets/SpriteSheets/Items.png", "Assets/SpriteSheets/Items.xml")

	-- Wczytywanie Tilesetów i tilemap
	local tilemapsPath = "Assets/Levels/"
	local files = love.filesystem.getDirectoryItems(tilemapsPath)
	for i, file in ipairs(files) do
		local fileExtension = file:match("[^.]+$")
		local fileName = file:gsub(".[^.]+$", "")

		if fileExtension == "csv" then
			if(fileName:find("_Map")) then
				local levelName = fileName:gsub("_Map", "")
				tilemaps[levelName] = libs.iffy.newTilemap(levelName, tilemapsPath .. file)
			end
		end
	end
	local tilesetsPath = "Assets/Levels/Tilesets/"
	local files = love.filesystem.getDirectoryItems(tilesetsPath)
	for key, file in ipairs(files) do
		local fileExtension = file:match("[^.]+$")
		local fileName = file:gsub(".[^.]+$", "")

		if fileExtension == "png" then
			libs.iffy.newTileset(fileName, tilesetsPath .. file)
		end
	end
	
	libs.gameState.registerEvents()
	libs.gameState.switch(states.menu)
end

function love.update(dt)
	Input:update()
	libs.talkies.update(dt)
end