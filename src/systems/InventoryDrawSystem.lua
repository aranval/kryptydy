local InventoryDrawSystem = libs.tiny.processingSystem(libs.class{})
InventoryDrawSystem.isDrawingSystem = true
InventoryDrawSystem.isGUI = true

InventoryDrawSystem.filter = libs.tiny.requireAll("items")


function InventoryDrawSystem:process(entity, dt)
    if entity.isOpen == false then return nil end
    entity.image9Patch:draw(entity.position.x, entity.position.y, entity.size.x, entity.size.y)
    
    local i = 1
    for key, value in pairs(entity.items) do
        local x, y = entity.position.x + CONST.inventoryItemsMargin, entity.position.y + i * CONST.inventoryItemsMargin

        if(entity.currentIndex == i) then
            love.graphics.rectangle("line", x - CONST.inventoryItemSelectBoxPadding, y - CONST.inventoryItemSelectBoxPadding, entity.size.x + CONST.inventoryItemSelectBoxPadding * 2 - CONST.inventoryItemsMargin * 2, CONST.inventoryItemsHeight + CONST.inventoryItemSelectBoxPadding * 2)
        end
        -- items globalna zmienna
        local item = items[key]
        libs.iffy.drawSprite(item.sprite, x, y)
        
        love.graphics.print(value, x + CONST.inventoryNumberOfItemXOffset, y + CONST.inventoryNumberOfItemYOffset)

        love.graphics.print(item.name, x + CONST.inventoryItemNameXOffset, y + CONST.inventoryItemNameYOffset)

        love.graphics.print(item.description, x + CONST.inventoryItemDescriptionXOffset, y + CONST.inventoryItemDescriptionYOffset)

        i = i + 1
    end
end

return InventoryDrawSystem