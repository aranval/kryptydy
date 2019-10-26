local ButtonUpdateSystem = libs.tiny.processingSystem(libs.class{})

ButtonUpdateSystem.filter = libs.tiny.requireAll("isButton")
function ButtonUpdateSystem:init() 
    self.canPress = true
end

function ButtonUpdateSystem:process(entity, dt)
    if entity.isButton == false then return nil end

    if(libs.talkies.isOpen()) then
        self.canPress = false
    end

    if Input:pressed("action") and entity.isActive and self.canPress then
        if type(entity.onPress) == "table" then
            for i, value in ipairs(entity.onPress) do
                value()
            end
        else
            entity:onPress()
        end
    end

end

function ButtonUpdateSystem:postProcess(dt)
    self.canPress = not libs.talkies.isOpen()
end

return ButtonUpdateSystem

