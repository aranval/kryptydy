local Player = libs.class{
    init = function(self, x, y)
        self.name = "Player"
        self.isPlayer = true
        self.pos = libs.vector(x or 0, y or 0)
        self.collider = classes.collider(32, 32)
        self.speed = 32*5
        self.animation = assets.anim_Player
        self.animationTag = "Up"
        self.direction = "Up"
        self.isHorizontalMove = true
        
        self.controlable = true
    end
}
return Player