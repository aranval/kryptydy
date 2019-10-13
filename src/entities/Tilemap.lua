local Tilemap = libs.class{
    init = function(self, tilemap, tileset)
        nilError("tilemap", tilemap)
        nilError("tileset", tileset)

        self.tilemap = tilemap
        self.tileset = tileset
    end    
}

return Tilemap