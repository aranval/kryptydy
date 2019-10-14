colliderIndex = 1
playerIndex = 2

goToTestLevel1 = 3
goToTestLevel2 = 4

testNPC1 = 5
testNPC2 = 6
testNPC3 = 7

function tableCopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[tableCopy(orig_key)] = tableCopy(orig_value)
        end
        setmetatable(copy, tableCopy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

function distance(x1, y1, x2, y2)
    local dx = x1 - x2
    local dy = y1 - y2
    return math.sqrt (dx * dx + dy * dy)
end

function generateCollisionsFromStartup(startup, bumpWorld, tileSize) 
    local x, y = 0, 0
    for line in love.filesystem.lines(startup)  do
        x=0
        for tile_no in line:gmatch("[^,]+") do            
            if(tonumber(tile_no) == colliderIndex) then
                bumpWorld:add({name = "Tile"}, x*32, y*32, tileSize, tileSize)
            end
            x = x + 1
        end
        y = y + 1
    end
end

function getPlayerPositionFromStartup(startup, tileSize) 
    local x, y = 0, 0
    for line in love.filesystem.lines(startup) do
        x=0
        for tile_no in line:gmatch("[^,]+") do
            if tonumber(tile_no) == playerIndex then
                return x*tileSize, y*tileSize
            end
            x = x + 1
        end
        y = y + 1
    end
end

function getEntitiesFromStartup(startup, tileSize)
    local ret = {{}}
    local x, y = 0, 0
    for line in love.filesystem.lines(startup) do
        x=0
        for tile_no in line:gmatch("[^,]+") do
            if tonumber(tile_no) == goToTestLevel1 then
                ret[#ret+1] = entities.gotoState(x * tileSize, y * tileSize, states.testLevel1)
            end
            if tonumber(tile_no) == goToTestLevel2 then                
                ret[#ret+1] = entities.gotoState(x * tileSize, y * tileSize, states.testLevel2)
            end
            if tonumber(tile_no) == testNPC1 then                
                ret[#ret+1] = entities.testNPC(x * tileSize, y * tileSize, assets.anim_InteractTest1)
            end
            if tonumber(tile_no) == testNPC2 then                
                ret[#ret+1] = entities.testNPC(x * tileSize, y * tileSize, assets.anim_InteractTest2)
            end
            if tonumber(tile_no) == testNPC3 then                
                ret[#ret+1] = entities.testNPC(x * tileSize, y * tileSize, assets.anim_InteractTest3)
            end
            x = x + 1
        end
        y = y + 1
    end
    return unpack(ret)
end

function debugDraw(isTrue)
    if isTrue then
        local items, len = bumpWorld:getItems()
        for i=1, len do
            local item = items[i]
            local x,y,w,h = bumpWorld:getRect(item)

            love.graphics.setColor(0,0,127)
            if item.collider and item.collider.isTrigger then
                love.graphics.setColor(127,127,0)
            end
            love.graphics.rectangle("fill", x, y, w, h)
            love.graphics.setColor(255,255,255)
            
        end
    end
end

function nilError(name, value) 
    if(value == nil) then
        error(name .. " is nil")
    end
end