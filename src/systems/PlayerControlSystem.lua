local PlayerControlSystem  = tiny.processingSystem()

PlayerControlSystem.filter = tiny.requireAll("controlable")

function PlayerControlSystem:process(e, dt)
    local inputX, inputY = Input:get("move")

    if(Input:pressed("left") or Input:pressed("right") or Input:released("up") or Input:released("down")) then
        e.isHorizontalMove = true
    elseif Input:pressed("up") or Input:pressed("down") or Input:released("left") or Input:released("right") then
        e.isHorizontalMove = false
    end

    if e.isHorizontalMove then
        inputY = 0  
        if inputX > 0 then 
            inputX = 1
            e.direction = "Right"
        elseif inputX < 0 then
            inputX = -1
            e.direction = "Left"
        end
    else
        inputX = 0
        if inputY > 0 then
            inputY = 1
            e.direction = "Down"
        elseif inputY < 0 then
            inputY = -1
            e.direction = "Up"
        end        
    end

    e.x = e.x + inputX * e.speed * dt
    e.y = e.y + inputY * e.speed * dt
end

return PlayerControlSystem 
