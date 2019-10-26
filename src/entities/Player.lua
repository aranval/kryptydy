local Player = libs.class{
    init = function(self, x, y)
        if x == nil then x = 0 end
        if y == nil then y = 0 end

        x = x * CONST.tileSize
        y = y * CONST.tileSize

        self.name = "Player"
        self.isPlayer = true
        self.isDead = false
        self.position = libs.vector(x, y)
        self.collider = classes.collider(32, 32)
        self.animation = libs.peachy.new("Assets/Animations/Player.json", love.graphics.newImage("Assets/Animations/Player.png"), "Idle")
        self.animationTag = "Idle"

        -- Movement
        self.currentPosition = libs.vector(x, y)
        self.nextPosition = libs.vector(x, y)  
        self.speed = CONST.playerSpeed
        self.isMoving = false
        self.direction = "Up"
        
        -- Input
        self.controlable = true
        self.isHorizontalMove = true
    end
}
return Player