local states = {}

states.menu = require("src/states/MenuState")
states.battle = require("src/states/BattleState")
states.level = require("src/states/LevelState")
states.gameOver = require("src/states/GameOverState")

return states