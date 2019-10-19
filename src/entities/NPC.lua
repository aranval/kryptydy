local function loadDialoguesFromFile(npcName)
    local dialoguesPath = "Assets/Story/" .. npcName .. ".txt"
    local info = love.filesystem.getInfo(dialoguesPath)
    if info == nil then 
        return nil 
    end

    -- Wczytanie pliku do tablicy
    return doFile(dialoguesPath)
end

local NPC = libs.class{
    init = function(self, name, x, y, animation)
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

        self.dialogues = loadDialoguesFromFile(name)        

        -- Movement
        self.currentPosition = libs.vector(x, y)
        self.nextPosition = libs.vector(x, y)        
        self.speed = CONST.npcSpeed
        self.isMoving = false

        self.isInteractive = true
    end,
    interact = function(self)
        if self.dialogues ~= nil then
            local dialogues = copyTable(self.dialogues)

            -- Domyślny dialog
            local dialogue = dialogues.default
            local oncompleteFunction = table.remove(dialogue, #dialogue)

            -- Sprawdzenie warunków            
            for key, value in pairs(dialogues) do
                if key ~= "default" then
                    local checkFunction = value[1]
                    if checkFunction() then
                        dialogue = dialogues[key]
                        table.remove(dialogue, 1)                        
                        oncompleteFunction = table.remove(dialogue, #dialogue)
                        break
                    end
                end
            end            

            -- Przekazanie dialogu do talkies
            local lenght = #dialogue
            for i=1, lenght do
                local name = ""
                if dialogue[i][1] == "self" then
                    name = "Player"
                else
                    name = self.name
                end

                if i == lenght then
                    -- Ostatnie okno
                    libs.talkies.say(name, dialogue[i][2], {
                        oncomplete = function(dialog) 
                            oncompleteFunction(gameEvents)
                        end
                        })
                else
                    libs.talkies.say(name, dialogue[i][2])
                end
            end
        end
    end
}

return NPC