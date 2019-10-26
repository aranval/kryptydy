local Button = libs.class{
    init = function(self, battleState, x, y, width, height, text, image9Patch, onPress)
        self.battleState = battleState
        self.position = libs.vector(x, y)
        self.size = libs.vector(width, height)
        self.text = text
        self.image9Patch = libs.patchy.load(image9Patch)
        self.isActive = false

        self.isButton = true

        self.onPress = onPress or function() end
    end,
}

return Button