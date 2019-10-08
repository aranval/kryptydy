-- Inne
peachy = require("Libraries/peachy-master/peachy")

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
require("States/menuState")
require("States/gameState")
require("States/battleState")
require("States/gameOverState")

function love.load()
	GameState.registerEvents()
	GameState.switch(gameState)
end

function love.update(dt)
	Input:update()
end