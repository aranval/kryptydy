local TestLevelState = {}

function TestLevelState:enter(prev)    
    local startup = "Assets/Tilemaps/TestLevel_Startup.csv"
    bumpWorld = libs.bump.newWorld() -- bump world musi być stworzony przed tiny world    
    generateCollisionsFromStartup(startup, bumpWorld, tileSize)

    gotoState = nil
    self.playerEntity = entities.player(getPlayerPositionFromStartup(startup, tileSize))
    self.debugDraw = prev.debugDraw or false
    self.camera = libs.camera(self.playerEntity.pos.x ,self.playerEntity.pos.y)
    self.cameraSmoother = libs.camera.smooth.damped(cameraSpeed)
    libs.tiny.add(tinyWorld,
        require("src/systems/TileMapDrawSystem"),

        require("src/systems/PlayerControlSystem"),
        require("src/systems/CollisionSystem"),

        require("src/systems/AnimationUpdateSystem"),
        require("src/systems/AnimationDrawSystem"),
        
        self.playerEntity,
        entities.tilemap("TestLevel1", "TestSet"),
        getEntitiesFromStartup(startup, tileSize)
    )
end

function TestLevelState:leave()
    libs.tiny.clearEntities(tinyWorld)
    libs.tiny.clearSystems(tinyWorld)
    libs.tiny.refresh(tinyWorld)
end

function TestLevelState:update(dt)    
    if gotoState then
        libs.gameState.switch(gotoState)
    end

    tinyWorld:update(dt, updateSystemFilter);
    self.camera:lockPosition(self.playerEntity.pos.x, self.playerEntity.pos.y, self.cameraSmoother)  

    if(Input:pressed("debug")) then 
        if self.debugDraw then self.debugDraw = false
        elseif not self.debugDraw then self.debugDraw = true end
    end
end

function TestLevelState:draw()
    love.graphics.print("F1 - toggle debug")
    love.graphics.print("x - action", 0, 16)

    self.camera:attach() 
    tinyWorld:update(dt, drawSystemFilter);

    debugDraw(self.debugDraw) 

    self.camera:detach()    
end

return TestLevelState