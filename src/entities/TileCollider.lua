local TileCollider = libs.class{
    init = function(self, x, y)
        self.name = "TileCollider"
        self.pos = libs.vector(x, y)
        self.collider = classes.collider(32, 32)
    end
}
return TileCollider