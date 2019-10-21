local LevelState = {}

-- Zmiana poziomu
-- levelName - nazwa poziomu z "Assets/Levels"
local function switchLevel(levelState, levelName)
    local levelInfoPath = "Assets/Levels/" .. levelName .. "_Info.txt"
    local info = love.filesystem.getInfo(levelInfoPath)
    assert(info, "Level " .. levelName .. " don't exist.")

    -- Usuniecie wszystkich entities
    libs.tiny.clearEntities(tinyWorld)
    libs.tiny.refresh(tinyWorld)

    -- Wczytanie pliku do tablicy 
    local levelInfo = doFile(levelInfoPath)

    -- Tilemap
    libs.tiny.addEntity(tinyWorld, require("src/entities/Tilemap")(levelName, levelInfo.tileset))
    local tilemapWidth = #tilemaps[levelName] * CONST.tileSize
    local tilemapHeight = #tilemaps[levelName][1] * CONST.tileSize

    levelState.centerPoint = libs.vector(tilemapWidth * .5, tilemapHeight * .5)

    -- Colliders
    libs.tiny.add(tinyWorld, generateCollidersFromCSV(levelName))

    -- Entities
    for key, entityInfo in pairs(levelInfo.entities) do
        local type = string.lower(table.remove(entityInfo, 1))
        local entity = require("src/entities/"..type)(unpack(entityInfo))

        if type == "player" then
            levelState.cameraTarget = entity
            levelState.camera:lookAt(entity.position:unpack())
        end

        libs.tiny.addEntity(tinyWorld, entity)
    end

    if(levelState.cameraTarget == nil) then
        levelState.camera:lookAt(levelState.centerPoint:unpack())
    end
end

function LevelState:enter(prev)    
    bumpWorld = libs.bump.newWorld() -- bump world musi być stworzony przed tiny world

    libs.tiny.add(tinyWorld,
        -- Systems
        require("src/systems/TileMapDrawSystem"),
        
        require("src/systems/PlayerControlSystem"),
        
        require("src/systems/MovementSystem"),
        require("src/systems/CollisionSystem"),

        require("src/systems/AnimationUpdateSystem"),
        require("src/systems/AnimationDrawSystem")
    )

    self.nextLevel = nil

    -- Vector uzywany do wycentrowania kamery
    self.centerPoint = libs.vector(0, 0)

    self.camera = libs.camera(0 ,0)
    self.cameraSmoother = libs.camera.smooth.damped(CONST.cameraSpeed)
    self.cameraTarget = nil
end

function LevelState:leave()
    libs.tiny.clearEntities(tinyWorld)
    libs.tiny.clearSystems(tinyWorld)
    libs.tiny.refresh(tinyWorld)
end

function LevelState:update(dt)
    -- Przejście do innego poziomu gdy zmienna globalna switchToLevel ma inną warość niż nil
    if(switchToLevel ~= nil) then
        switchLevel(self, switchToLevel)
        switchToLevel = nil
    end

    tinyWorld:update(dt, updateSystemFilter)

    -- Camera Update
    local cameraX, cameraY = 0, 0
    if self.cameraTarget == nil then
        cameraX, cameraY = self.centerPoint:unpack()
    else
        cameraX, cameraY = self.cameraTarget.position:unpack()
    end

    self.camera:lockPosition(cameraX, cameraY, self.cameraSmoother)
end

function LevelState:draw()
    self.camera:attach() 
    tinyWorld:update(dt, drawSystemFilter);
    --drawDebug(true)
    self.camera:detach()    

    -- Okno dialogowe
    libs.talkies:draw()

    --Draw Inventory DEBUG
    love.graphics.print(inventory.lenght, 1, 42)
    local i = 0
    for key, value in pairs(inventory.items) do
        libs.iffy.drawSprite(items[key].sprite, i*32, 0)
        love.graphics.print(value, i*32, 0)
        i = i + 1
    end
end

return LevelState