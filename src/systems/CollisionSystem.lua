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

local function triggerActions(trigger)
    if trigger.isGoto then
        gotoState = trigger.stateTable
    end
end

function CollisionSystem:onAdd(e)
    bumpWorld:add(e, e.pos.x, e.pos.y, e.collider.width, e.collider.height)
end

function CollisionSystem:process(e, dt)
    if e.pos and e.isMoving then
        local actualX, actualY, cols, len = bumpWorld:move(e, e.pos.x, e.pos.y, collisionFilter)

        e.pos.x = actualX
        e.pos.y = actualY

        if len > 0 then
            e.isMoving = false
            e.nextPos = e.currentPos
            e.pos = e.currentPos
        end

        for i=1,len do
            if(cols[i].other.collider and cols[i].other.collider.isTrigger) then
                triggerActions(cols[i].other)
            end
        end
    end    
end

return CollisionSystem

