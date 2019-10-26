-- Nie obsługuje animacji tylko poruszanie obiektów
local MovementSystem = libs.tiny.processingSystem(libs.class{})

MovementSystem.filter = libs.tiny.requireAll("currentPosition", "nextPosition", "speed", "isMoving")

local function movement(entity, dt)
    local direction = (entity.nextPosition - entity.currentPosition):normalized() 
    entity.position = entity.position + direction * entity.speed * dt

    if direction.y < 0 then
        if entity.position.y <= entity.nextPosition.y then
            entity.currentPosition = entity.nextPosition:clone()
            entity.position.y = entity.nextPosition.y
            entity.isMoving = false
        end
    elseif direction.y > 0 then
        if entity.position.y >= entity.nextPosition.y then
            entity.currentPosition = entity.nextPosition:clone()
            entity.position.y = entity.nextPosition.y
            entity.isMoving = false
        end
    elseif direction.x < 0 then
        if entity.position.x <= entity.nextPosition.x then
            entity.currentPosition = entity.nextPosition:clone()
            entity.position.x = entity.nextPosition.x
            entity.isMoving = false
        end
    elseif direction.x > 0 then
        if entity.position.x >= entity.nextPosition.x then
            entity.currentPosition = entity.nextPosition:clone()
            entity.position.x = entity.nextPosition.x
            entity.isMoving = false
        end
    end
    
    -- Korekta kolizji
    if not entity.isMoving then
        bumpWorld:update(entity, entity.position.x, entity.position.y)
    end
end

function MovementSystem:process(entity, dt)    
    if entity.isMoving then
        movement(entity, dt)
    end
end

return MovementSystem

