local TileMapDrawSystem = tiny.processingSystem(Class {})
TileMapDrawSystem.isDrawingSystem = true

TileMapDrawSystem.filter = tiny.requireAll("tilemap", "tileset")

function TileMapDrawSystem:process(e, dt)
    iffy.drawTilemap(e.tilemap, e.tileset, 1)
end

return TileMapDrawSystem