local Player = libs.class{
    init = function(self, x, y)
        local l, t = x or 0, y or 0

        self.name = "Player"
        self.isPlayer = true
        self.pos = libs.vector(l, t)
        self.currentPos = libs.vector(l, t)
        self.nextPos = libs.vector(l, t)
        self.collider = classes.collider(32, 32)
        self.speed = 32*5

        self.animation = assets.anim_Player
        self.animationTag = "Idle"
        self.direction = "Up"
        self.isHorizontalMove = true
        self.isMoving = false
        
        self.controlable = true
    end
}
return Player