local GameOverState = {}

function GameOverState:init()
    self.fontBig = love.graphics.newFont(CONST.gameOverFont, CONST.gameOverFontBigSize, "normal")
    self.font = love.graphics.newFont(CONST.gameOverFont, CONST.gameOverFontSize, "normal")
end

function GameOverState:enter()
    pause = true
end

function GameOverState:update()
    if Input:pressed("action") then
        libs.gameState.switch(states.menu)
    end
end

function GameOverState:leave()
    pause = false
end

function GameOverState:draw()
    love.graphics.setFont(self.fontBig)
    love.graphics.setColor(0.5, 0.5, 0.5) 
    love.graphics.printf("Game Over", 0, 300, love.graphics.getWidth(), "center")
    
    love.graphics.setFont(self.font)
    love.graphics.setColor(1, 1, 1)
    love.graphics.printf("Back to Main Menu", 0, love.graphics.getHeight() - self.font:getHeight() - CONST.menuMargin, love.graphics.getWidth() - CONST.menuMargin, "right")
    love.graphics.setColor(1, 1, 1)
end

return GameOverState