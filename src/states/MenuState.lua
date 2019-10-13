local MenuState = {}

function MenuState:init()
    
end

function MenuState:update()
    libs.gameState.switch(states.testLevel1)
end

function MenuState:draw()
    
end

return MenuState