TestLevelState = {}

function TestLevelState:init()
    self.playerEntity = require("src/entities/Player")

    -- Collisions Init 
    -- bump world musi być stworzony przed tiny world
    bumpWorld = bump.newWorld()

    local startup = "Assets/Tilemaps/TestLevelStartup.csv"
    GenerateCollisionsFromStartup(startup, bumpWorld, tileSize)    
    self.playerEntity.x, self.playerEntity.y = GetPlayerPositionFromStartup(startup, tileSize)

    self.debugDraw = false
    self.camera = Camera(self.playerEntity.x ,self.playerEntity.y)
    self.world = tiny.world(
        require("src/systems/TileMapDrawSystem"),

        require("src/systems/PlayerControlSystem"),
        require("src/systems/CollisionSystem"),

        require("src/systems/AnimationUpdateSystem"),
        require("src/systems/AnimationDrawSystem"),
        
        self.playerEntity,
        require("src/entities/TestLevelTileMap")
    )
end

function TestLevelState:update(dt)    
    self.world:update(dt, updateSystemFilter);

    self.camera:lookAt(self.playerEntity.x ,self.playerEntity.y)
end

function TestLevelState:draw()
    self.camera:attach()
    self.world:update(dt, drawSystemFilter);
    self.camera:detach()    
end