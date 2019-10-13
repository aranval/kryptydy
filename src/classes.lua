local classes = {}

classes.collider = libs.class{
    init = function(self, width, height, isTrigger) 
        self.isTrigger = isTrigger or false
        self.width = width
        self.height = height
    end
}

return classes