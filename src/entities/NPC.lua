local NPC = libs.class{
    init = function(self, name, x, y, animation, canFight)
        nilError("animation", animation)
        if x == nil then x = 0 end
        if y == nil then y = 0 end

        x = x * CONST.tileSize
        y = y * CONST.tileSize

        self.name = name or "Name"
        self.position = libs.vector(x, y)
        self.collider = classes.collider(32, 32)
        self.animation = libs.peachy.new("Assets/Animations/" .. animation .. ".json", love.graphics.newImage("Assets/Animations/" .. animation .. ".png"), "Idle")
        self.animationTag = "Idle"

        self.dialogues, self.actions = loadStoryFile(name)
        self.canFight = canFight

        -- Movement
        self.currentPosition = libs.vector(x, y)
        self.nextPosition = libs.vector(x, y)        
        self.speed = CONST.npcSpeed
        self.isMoving = false

        self.isInteractive = true
    end,
    interact = function(self)
        if self.canFight then        
            libs.gameState.push(states.battle, self)
        elseif self.dialogues ~= nil then
            tryShowDialogue(self.dialogues)
        end        
    end
    
}

return NPC