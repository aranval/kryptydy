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

classes.inventory = libs.class{
    init = function(self)
        self.lenght = 0
        self.items = {}
    end,
    addItem = function(self, itemID, number)
        if(self.items[itemID] == nil) then
            self.lenght = self.lenght + 1
        end
        self.items[itemID] = (self.items[itemID] or 0) + (number or 1)

    end,
    removeItem = function(self, itemID, number)
        local number = number or 1

        if(self.items[itemID] >= number) then
            self.items[itemID] = self.items[itemID] - number
            if self.items[itemID] == 0 then
                self.items[itemID] = nil
            end
            self.lenght = self.lenght - 1
            return true
        end
        return false
    end,
    getNumberOfItem = function(self, itemID)
        return (self.items[itemID] or 0)
    end,
}

return classes