TestLevelState = {}

function TestLevelState:init()
    self.player = Player(0, 0, "Assets/Animations/PlayerAnim.json", "Assets/Animations/PlayerAnim.png", "Down");
    self.characters = { self.player }
    self.tilemap = "Testmap"
    self.tileset = "Testset"

    self.camera = Camera(self.player:getPosition())
end

function TestLevelState:update(dt)
    for i, character in ipairs(self.characters) do
        character:update(dt)
    end
    self.camera:lookAt(self.player:getPosition())
end

function TestLevelState:draw()
    self.camera:attach()
    iffy.drawTilemap(self.tilemap, self.tileset, 1)

    for i, character in ipairs(self.characters) do
        character:draw()
    end
    self.camera:detach()    
end