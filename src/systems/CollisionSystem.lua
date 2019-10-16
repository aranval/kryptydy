local CollisionSystem = libs.tiny.processingSystem()

CollisionSystem.filter = libs.tiny.requireAll("collider")

local function collisionFilter(e1, e2)
    if not e1.collider or not e2.collider then
        return "slide"
    end
    
    if e1.collider.isTrigger or e2.collider.isTrigger then 
        return "cross"
    end

    return "slide"
end

local function queryFilter(e)
    local bool = not e.collider.isTrigger
    return bool
end

local function triggerActions(e, trigger)
    if trigger.isGoto and e.isPlayer then
        gotoState = trigger.stateTable
    end
end

function CollisionSystem:onAdd(e)
    bumpWorld:add(e, e.pos.x, e.pos.y, e.collider.width, e.collider.height)
end

function CollisionSystem:process(e, dt)
    if e.isMoving then
        -- Sprawdza czy może się poruszyć
        local items, len = bumpWorld:queryRect(e.nextPos.x, e.nextPos.y, e.collider.width, e.collider.width, queryFilter)
        for i=1,len do
            if items[i] ~= e then
                e.isMoving = false
                e.nextPos = e.currentPos:clone()
                e.pos = e.currentPos:clone()
                return nil
            end 
        end

        -- Poruszanie 
        local actualX, actualY, cols, len = bumpWorld:move(e, e.pos.x, e.pos.y, collisionFilter)

        -- Triggery

        for i=1,len do
            if(cols[i].other.collider and cols[i].other.collider.isTrigger) then
                triggerActions(e, cols[i].other)
            else
                -- W tablicy kolizji nie powinno znajdować się nic poza triggerami
                print("Something wrong with collision")
            end

        end
    end    
end

return CollisionSystem

