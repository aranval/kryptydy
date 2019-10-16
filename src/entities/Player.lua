local Player = libs.class{
    init = function(self, x, y)
        local l, t = x or 0, y or 0

        self.name = "Player"
        self.isPlayer = true
        self.pos = libs.vector(l, t)
        self.collider = classes.collider(32, 32)
        self.animation = assets.anim_Player
        self.animationTag = "Idle"  

        -- Movement
        self.currentPos = libs.vector(l, t)
        self.nextPos = libs.vector(l, t)        
        self.speed = CONST.playerSpeed
        self.isMoving = false
        self.direction = "Up"
        
        -- Input
        self.controlable = true
        self.isHorizontalMove = true
    end
}
return Player