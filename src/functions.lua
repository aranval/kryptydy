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

function loadStoryFile(npcName)
    local storyPath = "Assets/Story/" .. npcName .. ".txt"
    local info = love.filesystem.getInfo(storyPath)
    if info == nil then 
        return nil 
    end

    -- Wczytanie pliku do tablicy
    return doFile(storyPath)
end

function tryShowDialogue(dialogues) 
    local dialogue = nil
    for key, value in pairs(dialogues) do
        local checkFunction = value[1]
        if checkFunction() then
            dialogue = dialogues[key]
            break
        end
    end

    if dialogue == nil then
        return false
    end

    local config = {
        oncomplete = function(dialog) 
            dialogue[4]()
            states.battle.refresh = true
        end,
    }

    if dialogue[5] then
        config.options = dialogue[5]
    end

    return true, libs.talkies.say(dialogue[2], dialogue[3], config)
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