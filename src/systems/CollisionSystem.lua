local CollisionSystem = tiny.processingSystem()

CollisionSystem.filter = tiny.requireAll("collider")

function CollisionSystem:onAdd(e)
    bumpWorld:add(e, e.x, e.y, e.collider.width, e.collider.height)
end

function CollisionSystem:process(e, dt)
   local actualX, actualY, cols, len = bumpWorld:move(e, e.x, e.y)
    e.x = actualX
    e.y = actualY
end

return CollisionSystem

