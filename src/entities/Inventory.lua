local Inventory = libs.class{
    init = function(self, image9Patch, x, y, width, height)
        self.lenght = 0
        self.items = {}
        self.isOpen = false
        self.currentIndex = 1

        self.image9Patch = libs.patchy.load(image9Patch)
        self.position = libs.vector(x, y)
        self.size = libs.vector(width, height)
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
                self.lenght = self.lenght - 1
            end            
            return true
        end
        return false
    end,
    getNumberOfItem = function(self, itemID)
        return (self.items[itemID] or 0)
    end,
    getSelectedItemID = function(self)
        local i = 1
        for key, value in pairs(self.items) do
            if i == self.currentIndex then
                return key
            end 
            i = i + 1
        end
    end
}

return Inventory