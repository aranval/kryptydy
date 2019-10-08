Player = Class{__includes = Character}

function Player:init(x, y, animationJson, animationImage, animationStartTag)
    Character:init(x, y, animationJson, animationImage, animationStartTag)
    self.horizontal = true
end

function Player:update(dt)
    local inputX, inputY = Input:get("move")

    if(Input:pressed("left") or Input:pressed("right") or Input:released("up") or Input:released("down")) then
        self.horizontal = true
    elseif Input:pressed("up") or Input:pressed("down") or Input:released("left") or Input:released("right") then
        self.horizontal = false
    end

    if self.horizontal then
        inputY = 0  
        if inputX > 0 then 
            inputX = 1
            Character.moveDirection = "Right"
        elseif inputX < 0 then
            inputX = -1
            Character.moveDirection = "Left"
        end
    else
        inputX = 0
        if inputY > 0 then
            inputY = 1
            Character.moveDirection = "Down"
        elseif inputY < 0 then
            inputY = -1
            Character.moveDirection = "Up"
        end        
    end

    Character:move(inputX * Character.speed * dt, inputY * Character.speed * dt)
    Character:update(dt)
end

function Player:draw() 
    Character:draw()
end