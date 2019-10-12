function GenerateCollisionsFromStartup(timemap, bumpWorld, tileSize) 
    local x, y = 0, 0
    for line in love.filesystem.lines(timemap)  do
        x=0
        for tile_no in line:gmatch("[^,]+") do
            local n = tonumber(tile_no)
            
            if(n == 1) then
                bumpWorld:add({name = "Tile"}, x*32, y*32, tileSize, tileSize)
            end
            
            x = x + 1
        end
        y = y + 1
    end
end

function GetPlayerPositionFromStartup(timemap, tileSize) 
    local x, y = 0, 0
    for line in love.filesystem.lines(timemap) do
        x=0
        for tile_no in line:gmatch("[^,]+") do
            if tonumber(tile_no) == 2 then
                return x*tileSize, y*tileSize
            end
            x = x + 1
        end
        y = y + 1
    end
end