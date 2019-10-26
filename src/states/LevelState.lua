local LevelState = {}

-- Zmiana poziomu
-- levelName - nazwa poziomu z "Assets/Levels"
local function switchLevel(tinyWorld, levelState, levelName)
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
            player = entity
            levelState.cameraTarget = entity
            levelState.camera:lookAt(entity.position:unpack())
        end

        libs.tiny.addEntity(tinyWorld, entity)
    end

    -- Dodanie inventory
    libs.tiny.addEntity(tinyWorld, inventory)

    if(levelState.cameraTarget == nil) then
        levelState.camera:lookAt(levelState.centerPoint:unpack())
    end
end

function LevelState:enter(prev)    
    bumpWorld = libs.bump.newWorld() -- bump world musi być stworzony przed tiny world
    self.tinyWorld = libs.tiny.world()
    libs.tiny.add(self.tinyWorld,
        -- Systems
        require("src/systems/TileMapDrawSystem")(),
        
        require("src/systems/PlayerControlSystem")(),
        
        require("src/systems/MovementSystem")(),
        require("src/systems/CollisionSystem")(),

        require("src/systems/AnimationUpdateSystem")(),
        require("src/systems/AnimationDrawSystem")(),

        require("src/systems/InventoryUpdateSystem")(),
        require("src/systems/InventoryDrawSystem")()
    )

    self.nextLevel = nil

    -- Vector uzywany do wycentrowania kamery
    self.centerPoint = libs.vector(0, 0)

    self.camera = libs.camera(0 ,0)
    self.cameraSmoother = libs.camera.smooth.damped(CONST.cameraSpeed)
    self.cameraTarget = nil
end

function LevelState:resume()
    
end

function LevelState:leave()
    moonshineEffect.disable(unpack(moonshineEffectNames))
    inventory.isOpen = false

    libs.tiny.clearEntities(self.tinyWorld)
    libs.tiny.clearSystems(self.tinyWorld)
    libs.tiny.refresh(self.tinyWorld)
end

function LevelState:update(dt)
    -- Przejście do innego poziomu gdy zmienna globalna switchToLevel ma inną warość niż nil
    if switchToLevel ~= nil then
        switchLevel(self.tinyWorld, self, switchToLevel)
        switchToLevel = nil
    end

    self.tinyWorld:update(dt, updateSystemFilter)

    -- Camera Update
    local cameraX, cameraY = 0, 0
    if self.cameraTarget == nil then
        cameraX, cameraY = self.centerPoint:unpack()
    else
        cameraX, cameraY = self.cameraTarget.position:unpack()
    end

    self.camera:lockPosition(cameraX, cameraY, self.cameraSmoother)

    
    if player.isDead then
        libs.gameState.switch(states.gameOver)
    end
end

function LevelState:draw()
    moonshineEffect.draw(function() 
        self.camera:attach() 
        self.tinyWorld:update(dt, drawSystemFilter);
        self.camera:detach() 
    end)  

    self.tinyWorld:update(dt, drawGUISystemFilter);

    -- Okno dialogowe
    libs.talkies:draw()
end

return LevelState