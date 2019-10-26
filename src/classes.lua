local classes = {}

classes.collider = libs.class{
    init = function(self, width, height, isTrigger) 
        self.isTrigger = isTrigger or false
        self.width = width
        self.height = height
    end
}

classes.item = libs.class{
    init = function(self, name, description, sprite)
        self.name = name
        self.description = description
        self.sprite = sprite
    end
}

return classes