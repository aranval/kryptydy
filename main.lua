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