TestLevel2State = {}

function TestLevel2State:enter(prev)
    self.playerEntity = require("src/entities/Player")
    local tilemapEntity = require("src/entities/TileMap")
    local startup = "Assets/Tilemaps/TestLevel2_Startup.csv"

    tilemapEntity.tilemap = "TestLevel2"
    tilemapEntity.tileset = "TestSet"

    gotoState = nil
    -- Collisions Init 
    -- bump world musi być stworzony przed tiny world
    bumpWorld = bump.newWorld()
    
    generateCollisionsFromStartup(startup, bumpWorld, tileSize)    
    self.playerEntity.pos.x, self.playerEntity.pos.y = getPlayerPositionFromStartup(startup, tileSize)

    self.debugDraw = prev.debugDraw or false
    self.camera = Camera(self.playerEntity.pos.x ,self.playerEntity.pos.y)
    self.cameraSmoother = Camera.smooth.damped(5)
    tiny.add(tinyWorld,
        require("src/systems/TileMapDrawSystem"),

        require("src/systems/PlayerControlSystem"),
        require("src/systems/CollisionSystem"),

        require("src/systems/AnimationUpdateSystem"),
        require("src/systems/AnimationDrawSystem"),
        
        self.playerEntity,
        tilemapEntity,
        getEntitiesFromStartup(startup, tileSize)
    )
end

function TestLevel2State:leave()
    tiny.clearEntities(tinyWorld)
    tiny.clearSystems(tinyWorld)
    tiny.refresh(tinyWorld)
end

function TestLevel2State:update(dt)
    if gotoState then
        GameState.switch(gotoState)
    end

    tinyWorld:update(dt, updateSystemFilter)
    self.camera:lockPosition(self.playerEntity.pos.x, self.playerEntity.pos.y, self.cameraSmoother)    

    if(Input:pressed("debug")) then 
        if self.debugDraw then self.debugDraw = false
        elseif not self.debugDraw then self.debugDraw = true end
    end
end

function TestLevel2State:draw()
    love.graphics.print("F1 - toggle debug")

    self.camera:attach() 
    tinyWorld:update(dt, drawSystemFilter);

    debugDraw(self.debugDraw)

    self.camera:detach()    
end