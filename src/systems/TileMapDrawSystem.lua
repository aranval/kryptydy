local TileMapDrawSystem = libs.tiny.processingSystem()
TileMapDrawSystem.isDrawingSystem = true

TileMapDrawSystem.filter = libs.tiny.requireAll("tilemap", "tileset")

function TileMapDrawSystem:process(e, dt)
    libs.iffy.drawTilemap(e.tilemap, e.tileset, 1)
end

return TileMapDrawSystem