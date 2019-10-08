gameState = {}

function gameState:init()
    self.characters = {
        Player(0, 0, "Animations/PlayerAnim.json", "Animations/PlayerAnim.png", "Down")
    }
end

function gameState:update(dt)
    for i, character in ipairs(self.characters) do
        character:update(dt)
    end
end

function gameState:draw()
    for i, character in ipairs(self.characters) do
        character:draw()
    end
end