local MenuState = {}

function MenuState:init()
    
end

function MenuState:update()
    libs.gameState.switch(states.level)
end

function MenuState:draw()
    
end

return MenuState