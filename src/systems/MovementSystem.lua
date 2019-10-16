-- Nie obsługuje animacji tylko poruszanie obiektów
local MovementSystem = libs.tiny.processingSystem()

MovementSystem.filter = libs.tiny.requireAll("currentPos", "nextPos", "speed", "isMoving")

local function movement(e, dt)
    local dir = (e.nextPos - e.currentPos):normalized() 
    e.pos = e.pos + dir * e.speed * dt

    if dir.y < 0 then
        if e.pos.y <= e.nextPos.y then
            e.currentPos = e.nextPos:clone()
            e.pos.y = e.nextPos.y
            e.isMoving = false
        end
    elseif dir.y > 0 then
        if e.pos.y >= e.nextPos.y then
            e.currentPos = e.nextPos:clone()
            e.pos.y = e.nextPos.y
            e.isMoving = false
        end
    elseif dir.x < 0 then
        if e.pos.x <= e.nextPos.x then
            e.currentPos = e.nextPos:clone()
            e.pos.x = e.nextPos.x
            e.isMoving = false
        end
    elseif dir.x > 0 then
        if e.pos.x >= e.nextPos.x then
            e.currentPos = e.nextPos:clone()
            e.pos.x = e.nextPos.x
            e.isMoving = false
        end
    end
    
    -- Korekta kolizji
    if not e.isMoving then
        bumpWorld:update(e, e.pos.x, e.pos.y)
    end
end

function MovementSystem:process(e, dt)    
    if e.isMoving then
        movement(e, dt)
    end
end

return MovementSystem

