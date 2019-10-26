local ButtonDrawSystem = libs.tiny.processingSystem(libs.class{})
ButtonDrawSystem.isDrawingSystem = true

ButtonDrawSystem.filter = libs.tiny.requireAll("isButton")

function ButtonDrawSystem:process(entity, dt)
    if entity.isButton == false then return nil end
    local text = entity.text
    if entity.isActive then
        text = "#" .. text .. "#"
    end 

    love.graphics.setColor(255, 255, 255, 255)
    entity.image9Patch:draw(entity.position.x, entity.position.y, entity.size.x, entity.size.y)

    love.graphics.setColor(0, 0, 0, 255)    
    love.graphics.printf(text, entity.position.x, entity.position.y+18, entity.size.x, "center")
    love.graphics.setColor(255, 255, 255, 255)
end

return ButtonDrawSystem