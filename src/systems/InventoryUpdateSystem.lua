local InventoryUpdateSystem = libs.tiny.processingSystem(libs.class{})

InventoryUpdateSystem.filter = libs.tiny.requireAll("items")

function InventoryUpdateSystem:process(entity, dt)
    if entity.isOpen then
        moonshineEffect.enable(unpack(moonshineEffectNames))
        if Input:pressed("up") then
            entity.currentIndex = entity.currentIndex - 1
            if entity.currentIndex < 1 then
                entity.currentIndex = entity.lenght
            end 
        elseif Input:pressed("down") then
            entity.currentIndex = entity.currentIndex + 1
            if entity.currentIndex > entity.lenght then
                entity.currentIndex = 1
            end 
        end
    else
        moonshineEffect.disable(unpack(moonshineEffectNames))
        entity.currentIndex = 1
    end

    if libs.gameState.current() == states.level and Input:pressed("inventory") and not libs.talkies.isOpen() then
        entity.isOpen = not entity.isOpen
    end
end

return InventoryUpdateSystem

