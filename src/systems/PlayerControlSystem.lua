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
        e.nextPos = e.nextPos + input * CONST.tileSize
        e.isMoving = true
    else
        e.animationTag = "Idle"
    end
end

local function interactFilter(e) 
    return e.isInteractive
end

local function interact(e, dt)
    if Input:pressed("action") then
        local l, t, w, h = 0, 0, 0, 0

        if e.direction == "Up" then
            l = e.pos.x - CONST.tileSize
            t = e.pos.y - CONST.tileSize
            w = CONST.tileSize * 3
            h = CONST.tileSize
        elseif e.direction == "Down" then
            l = e.pos.x - CONST.tileSize
            t = e.pos.y + CONST.tileSize
            w = CONST.tileSize * 3
            h = CONST.tileSize
        elseif e.direction == "Left" then
            l = e.pos.x - CONST.tileSize
            t = e.pos.y - CONST.tileSize
            w = CONST.tileSize
            h = CONST.tileSize * 3
        elseif e.direction == "Right" then
            l = e.pos.x + CONST.tileSize
            t = e.pos.y - CONST.tileSize
            w = CONST.tileSize
            h = CONST.tileSize * 3
        end 

        local items, len = bumpWorld:queryRect(l,t,w,h, interactFilter)

        if len > 0 then
            local item = items[1]
            local minDist = e.pos:dist(item.pos)
            for i = 2, len do 
                local dist = e.pos:dist(item[i].pos)
                if dist < minDist then
                    item = items[i]
                    minDist = dist
                end
            end   

            item:interact() -- wywołanie funkcji intaract z Entity
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

    -- Talkies i interakcje
    if not libs.talkies.isOpen() then
        interact(e, dt)
    end
    if Input:pressed("action") then
		libs.talkies.onAction()
	end
end

return PlayerControlSystem 
