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
            local dia = self.dialogue.chooseDialogue(gameEvents)
            local len = #dia
            
            for i=1, len do
                local name = ""
                if dia[i][1] == "self" then
                    name = "Player"
                else
                    name = "NPC"
                end

                if i == len then
                    libs.talkies.say(name, dia[i][2], {
                        oncomplete = function(dialog) 
                            self.animationTag = "Idle"
                        end
                        })
                else
                    libs.talkies.say(name, dia[i][2])
                end
            end
            
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