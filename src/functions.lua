function doFile (filename)
    local str = love.filesystem.read(filename)
    local f = assert(loadstring(str))
    return f()
end

function copyTable(table)
    local table_type = type(table)
    local copy
    if table_type == 'table' then
        copy = {}
        for table_key, table_value in next, table, nil do
            copy[copyTable(table_key)] = copyTable(table_value)
        end
        setmetatable(copy, copyTable(getmetatable(table)))
    else
        copy = table
    end
    return copy
end

function generateCollidersFromCSV(levelName)
    local colliders = {}
    local x, y = 0, 0
    for line in love.filesystem.lines("Assets/Levels/" .. levelName .. "_Colliders.csv") do
        x = 0
        for tile_no in line:gmatch("[^,]+") do
            if(tonumber(tile_no) == 1) then
                colliders[#colliders+1] = require("src/entities/TileCollider")(x, y)
            end
            x = x + 1
        end
        y = y + 1
    end
    return unpack(colliders)
end

function drawDebug(isTrue)
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
    assert(value, name .. " is nil")
end