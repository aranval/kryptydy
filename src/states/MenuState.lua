local MenuState = {}

local function newGame() 
    -- Reset inventory i gameEvents
    inventory = require("src/entities/Inventory")(CONST.inventory9Patch, CONST.inventoryWindowX, CONST.inventoryWindowY, CONST.inventoryWindowWidth, CONST.inventoryWindowHeight)
	gameEvents = doFile("Assets/Story/GameEvents.txt")

    switchToLevel = "TestLevel"
    libs.gameState.switch(states.level)
end

function MenuState:init()
    
end

function MenuState:update()   

end

function MenuState:keypressed()
    newGame()
end

function MenuState:draw()
    love.graphics.printf("x - Action", 0, 275, 1024, "center")
    love.graphics.printf("i - Inventory", 0, 300, 1024, "center")

    love.graphics.printf("Press any to continue...", 0, 350, 1024, "center")
end

return MenuState