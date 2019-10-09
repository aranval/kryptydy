TestLevelState = {}

function TestLevelState:init()
    self.characters = {
        Player(0, 0, "Assets/Animations/PlayerAnim.json", "Assets/Animations/PlayerAnim.png", "Down")
    }
    self.tilemap = "Testmap"
    self.tileset = "Testset"
end

function TestLevelState:update(dt)
    for i, character in ipairs(self.characters) do
        character:update(dt)
    end
end

function TestLevelState:draw()
    iffy.drawTilemap(self.tilemap, self.tileset, 1)

    for i, character in ipairs(self.characters) do
        character:draw()
    end

    
end