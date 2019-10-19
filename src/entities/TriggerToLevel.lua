local TriggerToLevel = libs.class{
    init = function(self, x, y, levelName)
        nilError("stateTable", levelName)
        if x == nil then x = 0 end
        if y == nil then y = 0 end

        x = x * CONST.tileSize
        y = y * CONST.tileSize

        self.name = "TriggerToLevel"
        self.position = libs.vector(x, y)
        self.collider = classes.collider(32, 32, true)

        -- Nazwa poziomu do którego prowadzi trigger
        self.levelName = levelName

        -- Flaga używana do rozpoznania typu triggera
        self.isGoto = true
    end
}
return TriggerToLevel