-- TODO:
-- Do roździelenia na PlayerControlSystem i MovementSystem
-- Poprawa animacji 
-- Poprawa zmiany kierunku

local PlayerControlSystem  = libs.tiny.processingSystem()

PlayerControlSystem.filter = libs.tiny.requireAll("controlable")

local function movementInput(e, dt) 
    local input = libs.vector(Input:get("move"))

    if e.isHorizontalMove then
        input.y = 0  
        if input.x > 0 then 
            input.x = 1
            e.direction = "Right"
        elseif input.x < 0 then
            input.x = -1
            e.direction = "Left"
        end
    else
        input.x = 0
        if input.y > 0 then
            input.y = 1
            e.direction = "Down"
        elseif input.y < 0 then
            input.y = -1
            e.direction = "Up"
        end        
    end

    if(input:len() > 0) then
        e.animationTag = e.direction
        e.nextPos = e.nextPos + input * tileSize
        e.isMoving = true
    else
        e.animationTag = "Idle"
    end
end

local function movementFilter(e)
    if e.isPlayer then
        return false
    end
    if e.collider and e.collider.isTrigger then
        return false
    end
    return true
end

local function movement(e, dt)
    local dir = (e.nextPos - e.currentPos):normalized() 
    e.pos = e.pos + dir * e.speed * dt

    if e.direction == "Up" then
        if e.pos.y < e.nextPos.y then
            e.currentPos = e.nextPos
            e.pos.y = e.nextPos.y
            e.isMoving = false
        end
    elseif e.direction == "Down" then
        if e.pos.y > e.nextPos.y then
            e.currentPos = e.nextPos
            e.pos.y = e.nextPos.y
            e.isMoving = false
        end
    elseif e.direction == "Left" then
        if e.pos.x < e.nextPos.x then
            e.currentPos = e.nextPos
            e.pos.x = e.nextPos.x
            e.isMoving = false
        end
    elseif e.direction == "Right" then
        if e.pos.x > e.nextPos.x then
            e.currentPos = e.nextPos
            e.pos.x = e.nextPos.x
            e.isMoving = false
        end
    end
    
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
        end        
    end
end

function PlayerControlSystem:process(e, dt)
    if(Input:pressed("left") or Input:pressed("right") or Input:released("up") or Input:released("down")) then
        e.isHorizontalMove = true
    elseif Input:pressed("up") or Input:pressed("down") or Input:released("left") or Input:released("right") then
        e.isHorizontalMove = false
    end

    if not e.isMoving then
        movementInput(e, dt)
    end
    
    if e.isMoving then
        movement(e, dt)
    end
    interact(e, dt)
end

return PlayerControlSystem 
