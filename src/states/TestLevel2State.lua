local TestLevel2State = {}

function TestLevel2State:enter(prev)
    local startup = "Assets/Tilemaps/TestLevel2_Startup.csv"
    bumpWorld = libs.bump.newWorld() -- bump world musi być stworzony przed tiny world

    gotoState = nil
    self.playerEntity = entities.player(getPlayerPositionFromStartup(startup, tileSize))
    local camX, camY = self.playerEntity.pos:unpack()
    if camCenterDebug then -- DEBUG
        camX = 320
        camY = 320
    end -- DEBUG
    self.camera = libs.camera(camX ,camY)
    self.cameraSmoother = libs.camera.smooth.damped(CONST.cameraSpeed)
    libs.tiny.add(tinyWorld,
        require("src/systems/TestSystem"), -- TODO: Do usunięcia
        require("src/systems/TileMapDrawSystem"),

        require("src/systems/PlayerControlSystem"),
        require("src/systems/MovementSystem"),
        require("src/systems/CollisionSystem"),

        require("src/systems/AnimationUpdateSystem"),
        require("src/systems/AnimationDrawSystem"),
        
        self.playerEntity,
        entities.tilemap("TestLevel2", "TestSet"),
        getEntitiesFromStartup(startup, tileSize)
    )
end

function TestLevel2State:leave()
    libs.tiny.clearEntities(tinyWorld)
    libs.tiny.clearSystems(tinyWorld)
    libs.tiny.refresh(tinyWorld)
end

function TestLevel2State:update(dt)
    if gotoState then
        libs.gameState.switch(gotoState)
    end

    tinyWorld:update(dt, updateSystemFilter)
    local camX, camY = self.playerEntity.pos:unpack()
    if camCenterDebug then -- DEBUG
        camX = 320
        camY = 320
    end -- DEBUG
    self.camera:lockPosition(camX, camY, self.cameraSmoother)
end

function TestLevel2State:draw()

    self.camera:attach() 
    tinyWorld:update(dt, drawSystemFilter);

    debugDraw(drawDebug) -- DEBUG

    self.camera:detach()    

    -- Okno dialogowe
    libs.talkies:draw()

    -- DEBUG
    love.graphics.print("F1 - rysowanie kolizji")
	love.graphics.print("F2 - kamera na srodku", 0, 16)
    love.graphics.print("x - akcja", 0, 32)
end

return TestLevel2State