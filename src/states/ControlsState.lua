local ControlsState = {}

function ControlsState:init()
    pause = true
    self.font = love.graphics.newFont(CONST.menuFont, CONST.menuFontSize, "normal")
end

function ControlsState:enter(prev)
    pause = true
end

function ControlsState:resume()
    pause = true
end


function ControlsState:leave()
    pause = false
end

function ControlsState:update()
    if Input:pressed("action") then
        libs.gameState.pop()
    end
end

function ControlsState:draw()
    love.graphics.setFont(self.font)
    
    local windowWidth = love.graphics.getWidth()
    local windowHeight = love.graphics.getHeight()
    local margin = CONST.menuMargin
    local textHeight = self.font:getHeight()
    local marginTop = CONST.menuControlsMarginTop
    local marginLeft = CONST.menuControlsMarginLeft

    local rowMargin = windowWidth / 3
    love.graphics.setColor(0.5, 0.5, 0.5) 

    love.graphics.printf("",                    marginLeft + rowMargin * 0, margin + marginTop + (textHeight + CONST.menuControlsMarginBetween) * 0, rowMargin, "center")
    love.graphics.printf("",                    marginLeft + rowMargin * 0, margin + marginTop + (textHeight + CONST.menuControlsMarginBetween) * 1, rowMargin, "center")
    love.graphics.printf("Move Up",             marginLeft + rowMargin * 0, margin + marginTop + (textHeight + CONST.menuControlsMarginBetween) * 2, rowMargin, "center")
    love.graphics.printf("Move Down",           marginLeft + rowMargin * 0, margin + marginTop + (textHeight + CONST.menuControlsMarginBetween) * 3, rowMargin, "center")
    love.graphics.printf("Move Left",           marginLeft + rowMargin * 0, margin + marginTop + (textHeight + CONST.menuControlsMarginBetween) * 4, rowMargin, "center")
    love.graphics.printf("Move Right",          marginLeft + rowMargin * 0, margin + marginTop + (textHeight + CONST.menuControlsMarginBetween) * 5, rowMargin, "center")
    love.graphics.printf("Action",              marginLeft + rowMargin * 0, margin + marginTop + (textHeight + CONST.menuControlsMarginBetween) * 6, rowMargin, "center")
    love.graphics.printf("Back",                marginLeft + rowMargin * 0, margin + marginTop + (textHeight + CONST.menuControlsMarginBetween) * 7, rowMargin, "center")
    love.graphics.printf("Inventory",           marginLeft + rowMargin * 0, margin + marginTop + (textHeight + CONST.menuControlsMarginBetween) * 8, rowMargin, "center")

    love.graphics.line(margin * 0.5 + rowMargin * 1, marginTop - 5, margin * 0.5 + rowMargin * 1 , marginTop + 5 + (textHeight + CONST.menuControlsMarginBetween) * 10)

    love.graphics.printf("Keyboard",            marginLeft + rowMargin * 1, margin + marginTop + (textHeight + CONST.menuControlsMarginBetween) * 0, rowMargin, "center")
    love.graphics.printf("",                    marginLeft + rowMargin * 1, margin + marginTop + (textHeight + CONST.menuControlsMarginBetween) * 1, rowMargin, "center")
    love.graphics.printf("W / Arrow Up",        marginLeft + rowMargin * 1, margin + marginTop + (textHeight + CONST.menuControlsMarginBetween) * 2, rowMargin, "center")
    love.graphics.printf("S / Arrow Down",      marginLeft + rowMargin * 1, margin + marginTop + (textHeight + CONST.menuControlsMarginBetween) * 3, rowMargin, "center")
    love.graphics.printf("A  / Arrow Left",     marginLeft + rowMargin * 1, margin + marginTop + (textHeight + CONST.menuControlsMarginBetween) * 4, rowMargin, "center")
    love.graphics.printf("D / Arrow Right",     marginLeft + rowMargin * 1, margin + marginTop + (textHeight + CONST.menuControlsMarginBetween) * 5, rowMargin, "center")
    love.graphics.printf("Enter / X",           marginLeft + rowMargin * 1, margin + marginTop + (textHeight + CONST.menuControlsMarginBetween) * 6, rowMargin, "center")
    love.graphics.printf("ESC",                 marginLeft + rowMargin * 1, margin + marginTop + (textHeight + CONST.menuControlsMarginBetween) * 7, rowMargin, "center")
    love.graphics.printf("I",                   marginLeft + rowMargin * 1, margin + marginTop + (textHeight + CONST.menuControlsMarginBetween) * 8, rowMargin, "center")

    love.graphics.line(margin * 0.5 + rowMargin * 2, marginTop - 5, margin * 0.5 + rowMargin * 2 , marginTop + 5 + (textHeight + CONST.menuControlsMarginBetween) * 10)

    love.graphics.printf("Gamepad",             marginLeft + rowMargin * 2, margin + marginTop + (textHeight + CONST.menuControlsMarginBetween) * 0, rowMargin, "center")
    love.graphics.printf("",                    marginLeft + rowMargin * 2, margin + marginTop + (textHeight + CONST.menuControlsMarginBetween) * 1, rowMargin, "center")
    love.graphics.printf("Left stick",          marginLeft + rowMargin * 2, margin + marginTop + (textHeight + CONST.menuControlsMarginBetween) * 2, rowMargin, "center")
    love.graphics.printf("Left stick",          marginLeft + rowMargin * 2, margin + marginTop + (textHeight + CONST.menuControlsMarginBetween) * 3, rowMargin, "center")
    love.graphics.printf("Left stick",          marginLeft + rowMargin * 2, margin + marginTop + (textHeight + CONST.menuControlsMarginBetween) * 4, rowMargin, "center")
    love.graphics.printf("Left stick",          marginLeft + rowMargin * 2, margin + marginTop + (textHeight + CONST.menuControlsMarginBetween) * 5, rowMargin, "center")
    love.graphics.printf("A",                   marginLeft + rowMargin * 2, margin + marginTop + (textHeight + CONST.menuControlsMarginBetween) * 6, rowMargin, "center")
    love.graphics.printf("B",                   marginLeft + rowMargin * 2, margin + marginTop + (textHeight + CONST.menuControlsMarginBetween) * 7, rowMargin, "center")
    love.graphics.printf("Y",                   marginLeft + rowMargin * 2, margin + marginTop + (textHeight + CONST.menuControlsMarginBetween) * 8, rowMargin, "center")


    love.graphics.setColor(1, 1, 1) 
    love.graphics.printf("Back", 0, windowHeight - textHeight - margin, windowWidth - margin, "right")
    love.graphics.setColor(1, 1, 1) 
end

return ControlsState