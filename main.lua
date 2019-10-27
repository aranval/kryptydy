-- GLOBALNE
libs = require("src/libs")

classes = require("src/classes")
states = require("src/states")
CONST = require("src/constants")
fonts = {}

bumpWorld = nil
tilemaps = {}
switchToLevel = nil
player = nil

pause = true
battleState = nil
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
	  inventory = {'key:i', 'button:y'},
	  action = {'key:x', 'key:return', 'button:a'},
	  back = {'key:escape', 'button:b'}
	},
	pairs = {
	  move = {'left', 'right', 'up', 'down'}
	},
	joystick = love.joystick.getJoysticks()[1],
  }

-- ECS Filters
drawGUISystemFilter = libs.tiny.requireAll("isDrawingSystem", "isGUI")
drawSystemFilter = libs.tiny.requireAll("isDrawingSystem", libs.tiny.rejectAll("isGUI"))
drawAllSystemFilter = libs.tiny.requireAll("isDrawingSystem")

updateSystemFilter = libs.tiny.rejectAll("isDrawingSystem")

function love.load()
	love.graphics.setDefaultFilter("nearest", "nearest")	

	libs.iffy.newAtlas("Assets/SpriteSheets/Items.png", "Assets/SpriteSheets/Items.xml")

	-- Wczytanie itemów
	local itemsArray = doFile("Assets/Items.txt")
	for key, value in pairs(itemsArray) do
		items[key] = classes.item(value[1], value[2], value[3])
	end

	-- Moonshine - rozmazanie tła
	moonshineEffectNames = {"desaturate", "vignette"} -- pixelate, desaturate, scanlines, vignette
	moonshineEffect = libs.moonshine(libs.moonshine.effects.vignette)
		.chain(libs.moonshine.effects.desaturate)
	moonshineEffect.disable(unpack(moonshineEffectNames))

	-- Wczytanie Tilesetów i tilemap
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
	
	libs.talkies.font = love.graphics.newFont(CONST.talkiesFont, CONST.talkiesFontSize, "normal")

	libs.gameState.registerEvents()
	libs.gameState.switch(states.menu)
end

function love.update(dt)
	Input:update()
	if libs.gameState.current() ~= states.menu and Input:pressed("back") and not libs.talkies.isOpen() then
		if(libs.gameState.current() == states.controls) then
			libs.gameState.pop()
		else
			libs.gameState.push(states.menu, true)
		end
	end
	if not pause then
		if Input:pressed("action") then
			libs.talkies.onAction()
		end
		if Input:pressed("up") then
			libs.talkies.prevOption()
		end
		if Input:pressed("down") then
			libs.talkies.nextOption()
		end
		
		libs.talkies.update(dt)
	end
end
