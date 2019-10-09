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

-- Classes
Class = require("Libraries/hump-master/class")
require("Classes/Character")
require("Classes/Characters/Player")
require("Classes/Characters/Npc")
require("Classes/Characters/Cryptid")

-- GameStates
GameState = require("Libraries/hump-master/gamestate")
require("States/MenuState")
require("States/TestLevelState")
require("States/BattleState")
require("States/GameOverState")

function love.load()
	-- Wczytywanie Tilesetów i tilemap
	local t={}

	for line in love.filesystem.lines("Assets/Tilemaps/TestMap.csv") do
		local row={}
		i=1
		for tile_no in line:gmatch("[^,]+") do
			row[#row+1]=tonumber(tile_no)
			i=i+1
		end
		t[#t+1]=row
	end

	iffy.newTileset("Testset", "Assets/Tilemaps/TestTile.png")
    iffy.newTilemap("Testmap", t) -- Tablice trzeba wczytywać ręcznie, iffy wywala bład gdy da się jej tylko url.
	
	GameState.registerEvents()
	GameState.switch(TestLevelState)
end

function love.update(dt)
	Input:update()
end