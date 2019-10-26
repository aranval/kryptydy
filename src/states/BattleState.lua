local BattleState = {}

function tryShowActions(actions)
    if battleState == "menu" then
        libs.tiny.remove(BattleState.tinyWorld, unpack(BattleState.buttons))
        BattleState.buttons = BattleState.menuButtons;
        libs.tiny.add(BattleState.tinyWorld, unpack(BattleState.buttons))
        BattleState.refreshTinyWorld = true
        BattleState.currentButtonIndex = 1
        return true;
    elseif battleState == "item" or battleState == "useItem" then
        if BattleState.buttons == BattleState.itemButtons then
            return true
        end
        libs.tiny.remove(BattleState.tinyWorld, unpack(BattleState.buttons))
        BattleState.buttons = BattleState.itemButtons;
        libs.tiny.add(BattleState.tinyWorld, unpack(BattleState.buttons))
        BattleState.refreshTinyWorld = true
        BattleState.currentButtonIndex = 1
        return true
    end

    local ok = false
    for key, value in pairs(actions) do
        local checkFunction = value[1]
        if checkFunction() then
            if ok == false then
                libs.tiny.remove(BattleState.tinyWorld, unpack(BattleState.buttons))
                BattleState.buttons = {}
                BattleState.currentButtonIndex = 1
                ok = true                
            end
            local i = #BattleState.buttons
            BattleState.buttons[i+1] = require("src/entities/Button")(BattleState, 12 + i * (241 + 12), 706, 241, 50, value[2], "Assets/9Patch/button.9.png", 
            function() 
                value[3]() 
                BattleState.refresh = true 
            end)
        end
    end

    if ok == false  then
        return false
    end
    libs.tiny.add(BattleState.tinyWorld, unpack(BattleState.buttons))
    BattleState.refreshTinyWorld = true
    return true
end

local function fightButton()
    battleState = "fight"
    if not tryShowActions(BattleState.npc.actions) then
        backButton()
    end
end

local function itemButton()
    battleState = "item"
    inventory.isOpen = true
    tryShowActions(BattleState.npc.actions)
end

local function talkButton()
    battleState = "talk"
    if not tryShowDialogue(BattleState.npc.dialogues) then
        backButton()
    end
end

local function runButton()
    battleState = "run"
    tryShowDialogue(BattleState.npc.dialogues)
end

local function useItemButton()
    battleState = "useItem"
    if not tryShowDialogue(BattleState.npc.dialogues) then
        libs.talkies.say("", "...")
    end
    if battleState == "useItem" then
        battleState = "item"
    end
    tryShowActions(BattleState.npc.actions)
end

local function backButton()
    battleState = "menu"
    inventory.isOpen = false
    tryShowActions(BattleState.npc.actions)
end

function BattleState:enter(prev, npc)
    battleState = "menu"
    self.npc = npc
    self.refreshTinyWorld = false;
    self.refresh = false

    self.menuButtons = {
        require("src/entities/Button")(self, 12, 706, 241, 50, "Fight", "Assets/9Patch/button.9.png", fightButton),
        require("src/entities/Button")(self, 265, 706, 241, 50, "Item", "Assets/9Patch/button.9.png", itemButton),
        require("src/entities/Button")(self, 518, 706, 241, 50, "Talk", "Assets/9Patch/button.9.png", talkButton),
        require("src/entities/Button")(self, 771, 706, 241, 50, "Run", "Assets/9Patch/button.9.png", runButton)
    }
    self.itemButtons = {
        require("src/entities/Button")(self, 12, 706, 241, 50, "Use", "Assets/9Patch/button.9.png", useItemButton),
        require("src/entities/Button")(self, 265, 706, 241, 50, "Back", "Assets/9Patch/button.9.png", backButton),
    }

    self.buttons = self.menuButtons
    self.currentButtonIndex = 1
    
    self.tinyWorld = libs.tiny.world()
    libs.tiny.add(self.tinyWorld,
        -- Systems
        require("src/systems/ButtonUpdateSystem")(),
        require("src/systems/ButtonDrawSystem")(),

        require("src/systems/InventoryUpdateSystem")(),
        require("src/systems/InventoryDrawSystem")(),
        
        -- Entities
        inventory,
        unpack(self.buttons)        
    )

end

function BattleState:leave()
    battleState = nil
    moonshineEffect.disable(unpack(moonshineEffectNames))
    inventory.isOpen = false

    libs.tiny.clearEntities(self.tinyWorld)
    libs.tiny.clearSystems(self.tinyWorld)
    libs.tiny.refresh(self.tinyWorld)
end

function BattleState:update(dt)
    if battleState == "run" and libs.talkies.isOpen() == false then
        libs.gameState.pop()
    end

    if refreshTinyWorld then
        libs.tiny.refresh(BattleState.tinyWorld) 
        refreshTinyWorld = false
    end

    if self.refresh then
        tryShowActions(BattleState.npc.actions)
        tryShowDialogue(BattleState.npc.dialogues)
        self.refresh = false;
    end 

    if Input:pressed("left") then
        self.currentButtonIndex = self.currentButtonIndex - 1
        if self.currentButtonIndex < 1 then
            self.currentButtonIndex = #self.buttons
        end 
    elseif Input:pressed("right") then
        self.currentButtonIndex = self.currentButtonIndex + 1
        if self.currentButtonIndex > #self.buttons then
            self.currentButtonIndex = 1
        end 
    end

    for i, button in ipairs(self.buttons) do
        if i == self.currentButtonIndex then
            button.isActive = true
        else
            button.isActive = false
        end
    end

    libs.talkies.update(dt)
    self.tinyWorld:update(dt, updateSystemFilter)
end

function BattleState:draw()
    self.tinyWorld:update(dt, drawAllSystemFilter);

    libs.talkies:draw()
end

return BattleState