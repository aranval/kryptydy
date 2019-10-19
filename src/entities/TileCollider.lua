local TileCollider = libs.class{
    init = function(self, x, y)
        if x == nil then x = 0 end
        if y == nil then y = 0 end

        x = x * CONST.tileSize
        y = y * CONST.tileSize

        self.name = "TileCollider"
        self.position = libs.vector(x, y)
        self.collider = classes.collider(32, 32)
    end
}
return TileCollider