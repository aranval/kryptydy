local CollisionSystem = libs.tiny.processingSystem(libs.class{})

CollisionSystem.filter = libs.tiny.requireAll("collider")

local function collisionFilter(item, other)
    if not item.collider or not other.collider then
        return "slide"
    end
    
    if item.collider.isTrigger or other.collider.isTrigger then 
        return "cross"
    end

    return "slide"
end

local function queryFilter(entity)
    return not entity.collider.isTrigger
end

local function triggerActions(entity, trigger)
    if trigger.isGoto and entity.isPlayer then
        switchToLevel = trigger.levelName
    end
end

function CollisionSystem:onAdd(entity)
    bumpWorld:add(entity, entity.position.x, entity.position.y, entity.collider.width, entity.collider.height)
end

function CollisionSystem:process(entity, dt)
    if entity.isMoving then
        -- Sprawdza czy może się poruszyć
        local items, len = bumpWorld:queryRect(entity.nextPosition.x, entity.nextPosition.y, entity.collider.width, entity.collider.width, queryFilter)
        for i=1,len do
            if items[i] ~= entity then
                entity.isMoving = false
                entity.nextPosition = entity.currentPosition:clone()
                entity.position = entity.currentPosition:clone()
                return nil
            end 
        end

        -- Poruszanie 
        local actualX, actualY, cols, len = bumpWorld:move(entity, entity.position.x, entity.position.y, collisionFilter)

        -- Triggery

        for i=1,len do
            if(cols[i].other.collider and cols[i].other.collider.isTrigger) then
                triggerActions(entity, cols[i].other)
            else
                -- W tablicy kolizji nie powinno znajdować się nic poza triggerami
                print("Something wrong with collision")
            end

        end
    end    
end

return CollisionSystem

