local states = {}

states.menu = require("src/states/MenuState")
states.battleState = require("src/states/MenuState")

-- Test
states.testLevel1 = require("src/states/TestLevelState")
states.testLevel2 = require("src/states/TestLevel2State")

return states