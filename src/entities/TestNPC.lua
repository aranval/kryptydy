local TestNPC = libs.class{
    init = function(self, x, y, animation, dialogue)
        nilError("animation", animation)
        local l, t = x or 0, y or 0

        self.name = "Interactive"
        self.pos = libs.vector(l, t)
        self.collider = classes.collider(32, 32)
        self.animation = animation
        self.animationTag = "Idle"

        self.dialogue = dialogue

        -- Movement
        self.currentPos = libs.vector(l, t)
        self.nextPos = libs.vector(l, t)        
        self.speed = CONST.npcSpeed
        self.isMoving = false

        self.isInteractive = true
        self.isTest = true -- TODO: Do usunięcia po testach
    end,
    interact = function(self)
        if self.dialogue then
            local DIA = self.dialogue.chooseDialogue(gameEvents)

            print (self.dialogue.chooseDialogue(gameEvents))
            libs.talkies.say("Position", "X: ".. self.pos.x .. ", Y: " .. self.pos.y, {
                oncomplete = function(dialog) 
                    self.animationTag = "Idle"
                end
            })

            self.animationTag = "Interact"
        end
    end,
    -- Test Function
    move = function(self)
        if not self.isMoving and love.math.random(20) == 1 and self.animationTag == "Idle" then
            local rand = love.math.random(4)
            if rand == 1 then
                self.nextPos.y = self.nextPos.y + CONST.tileSize
            elseif rand == 2 then
                self.nextPos.y = self.nextPos.y - CONST.tileSize
            elseif rand == 3 then
                self.nextPos.x = self.nextPos.x + CONST.tileSize
            elseif rand == 4 then
                self.nextPos.x = self.nextPos.x - CONST.tileSize
            end
            self.isMoving = true
        end
    end
        
}

return TestNPC