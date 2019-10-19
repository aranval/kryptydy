local PlayerControlSystem  = libs.tiny.processingSystem()

PlayerControlSystem.filter = libs.tiny.requireAll("controlable")

local function movementInput(entity, dt) 
    local input = libs.vector(Input:get("move"))

    if entity.isHorizontalMove then
        input.y = 0  
        if input.x > 0 then 
            input.x = 1
            entity.direction = "Right"
        elseif input.x < 0 then
            input.x = -1
            entity.direction = "Left"
        end
    else
        input.x = 0
        if input.y > 0 then
            input.y = 1
            entity.direction = "Down"
        elseif input.y < 0 then
            input.y = -1
            entity.direction = "Up"
        end        
    end

    if(input:len() > 0) then
        entity.animationTag = entity.direction
        entity.nextPosition = entity.nextPosition + input * CONST.tileSize
        entity.isMoving = true
    else
        entity.animationTag = "Idle"
    end
end

local function interactFilter(entity) 
    return entity.isInteractive
end

local function interact(entity, dt)
    if Input:pressed("action") then
        local rectLeft, rectTop, rectWidth, rectHeight = 0, 0, 0, 0

        if entity.direction == "Up" then
            rectLeft = entity.position.x - CONST.tileSize
            rectTop = entity.position.y - CONST.tileSize
            rectWidth = CONST.tileSize * 3
            rectHeight = CONST.tileSize
        elseif entity.direction == "Down" then
            rectLeft = entity.position.x - CONST.tileSize
            rectTop = entity.position.y + CONST.tileSize
            rectWidth = CONST.tileSize * 3
            rectHeight = CONST.tileSize
        elseif entity.direction == "Left" then
            rectLeft = entity.position.x - CONST.tileSize
            rectTop = entity.position.y - CONST.tileSize
            rectWidth = CONST.tileSize
            rectHeight = CONST.tileSize * 3
        elseif entity.direction == "Right" then
            rectLeft = entity.position.x + CONST.tileSize
            rectTop = entity.position.y - CONST.tileSize
            rectWidth = CONST.tileSize
            rectHeight = CONST.tileSize * 3
        end 

        local items, lenght = bumpWorld:queryRect(rectLeft, rectTop, rectWidth, rectHeight, interactFilter)

        if lenght > 0 then
            local item = items[1]
            local minDistance = entity.position:dist(item.position)
            for i = 2, lenght do 
                local distance = entity.position:dist(items[i].position)
                if distance < minDistance then
                    item = items[i]
                    minDistance = distance
                end
            end   

            item:interact() -- wywołanie funkcji intaract z Entity
        end        
    end
end

function PlayerControlSystem:process(entity, dt)
    if(Input:pressed("left") or Input:pressed("right") or Input:released("up") or Input:released("down")) then
        entity.isHorizontalMove = true
    elseif Input:pressed("up") or Input:pressed("down") or Input:released("left") or Input:released("right") then
        entity.isHorizontalMove = false
    end

    if not entity.isMoving then
        movementInput(entity, dt)
    end

    -- Talkies i interakcje
    if not libs.talkies.isOpen() then
        interact(entity, dt)
    end
    if Input:pressed("action") then
		libs.talkies.onAction()
	end
end

return PlayerControlSystem 
