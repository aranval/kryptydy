local TileMapDrawSystem = libs.tiny.processingSystem(libs.class{})
TileMapDrawSystem.isDrawingSystem = true

TileMapDrawSystem.filter = libs.tiny.requireAll("tilemap", "tileset")

function TileMapDrawSystem:process(entity, dt)
    libs.iffy.drawTilemap(entity.tilemap, entity.tileset, 1)
end

return TileMapDrawSystem