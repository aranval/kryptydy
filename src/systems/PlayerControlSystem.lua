local PlayerControlSystem  = tiny.processingSystem()

PlayerControlSystem.filter = tiny.requireAll("controlable")

local function movement(e, dt) 
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

    e.animationTag = e.direction
    e.pos.x = e.pos.x + inputX * e.speed * dt
    e.pos.y = e.pos.y + inputY * e.speed * dt
end

local function interactFilter(e) 
    return e.isInteractive
end

local function interact(e, dt)
    if Input:pressed("action") then
        local l, t, w, h = 0, 0, 0, 0

        if e.direction == "Up" then
            l = e.pos.x - tileSize
            t = e.pos.y - tileSize
            w = tileSize * 3
            h = tileSize
        elseif e.direction == "Down" then
            l = e.pos.x - tileSize
            t = e.pos.y + tileSize
            w = tileSize * 3
            h = tileSize
        elseif e.direction == "Left" then
            l = e.pos.x - tileSize
            t = e.pos.y - tileSize
            w = tileSize
            h = tileSize * 3
        elseif e.direction == "Right" then
            l = e.pos.x + tileSize
            t = e.pos.y - tileSize
            w = tileSize
            h = tileSize * 3
        end 

        local items, len = bumpWorld:queryRect(l,t,w,h, interactFilter)

        if len > 0 then
            local item = items[1]
            local minDist = distance(e.pos.x, e.pos.y, item.pos.x, item.pos.y)
            for i = 2, len do 
                local dist = distance(e.pos.x, e.pos.y, items[i].pos.x, items[i].pos.y)
                if dist < minDist then
                    item = items[i]
                    minDist = dist
                end
            end   

            -- Iterakcja z najbliższym obiektem
            if item.animationTag == "Idle" then
                item.animationTag = "Interact"
            else 
                item.animationTag = "Idle"
            end
            print(item.name)
        end        
    end
end

function PlayerControlSystem:process(e, dt)
    movement(e, dt)
    interact(e, dt)
end

return PlayerControlSystem 
