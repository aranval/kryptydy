local GameOverState = {}

function GameOverState:enter()
    pause = true
end

function GameOverState:update()
    
end

function GameOverState:leave()
    pause = false
end

function GameOverState:keypressed() 
    libs.gameState.switch(states.menu, false)
end

function GameOverState:draw()
    love.graphics.printf("Game Over", 0, 300, 1024, "center")
    love.graphics.printf("Press any to continue...", 0, 350, 1024, "center")
end

return GameOverState