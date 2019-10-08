Character = Class{}

-- x                - pozycja na osi x
-- y                - pozycja na osi y
-- animationJson    - ścieżka do pliku *.json animacji
-- animationImage   - ścieżka do pliku *.png *.jpg itd. animacji
-- animationTag     - tag domyślnej animacji
--                    wielkość liter ma znaczenie
function Character:init(x, y, animationJson, animationImage, animationStartTag)
    self.x = x or 0
    self.y = y or 0
    self.animation = peachy.new(animationJson, love.graphics.newImage(animationImage), animationStartTag)
    self.speed = 96
    self.moveDirection = "Up" -- Up, Down, Left, Right
end

function Character:update(dt) 
    self.animation:update(dt)
    self:setAnimationTag(self.moveDirection);
end

function Character:draw()
    self.animation:draw(self.x, self.y)
end


function Character:move(x,y)
    self.x = self.x + x
    self.y = self.y + y
end

function Character:setAnimationTag(tag)
    self.animation:setTag(tag)
end