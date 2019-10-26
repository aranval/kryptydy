local GameOverState = {}

function GameOverState:enter()
    
end

function GameOverState:update()
    
end

function GameOverState:keypressed() 
    libs.gameState.switch(states.menu)
end

function GameOverState:draw()
    love.graphics.printf("Game Over", 0, 300, 1024, "center")
    love.graphics.printf("Press any to continue...", 0, 350, 1024, "center")
end

return GameOverState