local MenuState = {}

local function continue()
    libs.gameState.pop()
end

local function newGame() 
    -- Reset inventory i gameEvents
    inventory = require("src/entities/Inventory")(CONST.inventory9Patch, CONST.inventoryWindowX, CONST.inventoryWindowY, CONST.inventoryWindowWidth, CONST.inventoryWindowHeight)
	gameEvents = doFile("Assets/Story/GameEvents.txt")

    libs.talkies.clearMessages()

    switchToLevel = "TestLevel"
    libs.gameState.switch(states.level)
end

local function controls()
    libs.gameState.push(states.controls)
end

local function exit()
    love.event.quit()
end

function MenuState:init()
    self.options = {
        {"Continue", continue},
        {"New Game", newGame},
        {"Controls", controls},
        {"Exit", exit}
    }

    self.font = love.graphics.newFont(CONST.menuFont, CONST.menuFontSize, "normal")
    self.currentOptionIndex = 2
    self.canContinue = false
end

function MenuState:enter(prev, canContinue)
    pause = true
    if canContinue then
        self.currentOptionIndex = 1
        self.canContinue = true
    else
        self.currentOptionIndex = 2
        self.canContinue = false
    end
end

function MenuState:resume()
    pause = true
end


function MenuState:leave()
    pause = false
end

function MenuState:update()   
    if Input:pressed("up") then
        self.currentOptionIndex = self.currentOptionIndex - 1
        if self.currentOptionIndex < 1 then
            self.currentOptionIndex = #self.options
        end 

        if not self.canContinue then
            if self.currentOptionIndex == 1 then
                self.currentOptionIndex = #self.options
            end
        end
    elseif Input:pressed("down") then
        self.currentOptionIndex  = self.currentOptionIndex + 1
        if self.currentOptionIndex  > #self.options then
            self.currentOptionIndex  = 1
        end 

        if not self.canContinue then
            if self.currentOptionIndex == 1 then
                self.currentOptionIndex = 2
            end
        end
    end

    if Input:pressed("action") then
        self.options[self.currentOptionIndex][2]()
    end
end

function MenuState:draw()
    love.graphics.setFont(self.font)
    local windowWidth = love.graphics.getWidth()
    local windowHeight = love.graphics.getHeight()
    local margin = CONST.menuMargin
    local marginBetweenOptions = CONST.menuMarginBetweenOptions
    local textHeight = self.font:getHeight()

    local lenght = #self.options
    local x = 0
    local y = windowHeight - margin - textHeight
    for i = lenght, 1, -1 do
        love.graphics.setColor(0.5,0.5,0.5)
        if self.currentOptionIndex == i then
            love.graphics.setColor(1,1,1)            
        end
        if i == 1 and not self.canContinue then
            love.graphics.setColor(0.2,0.2,0.2)
        end
        love.graphics.printf(self.options[i][1], x, y, windowWidth - margin, "right")
        y = y - textHeight - marginBetweenOptions
    end
    love.graphics.setColor(1,1,1) 
end

return MenuState