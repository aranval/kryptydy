gameState = {}

function gameState:init()
    -- Tymczasowe do testu animacji
    speed = 100
    moveX = 0
    moveY = 0
    TestCharacter = Character(0, 0, "Animations/TestAnim.json", "Animations/TestAnim.png", "Up")
end

function gameState:update(dt)
    TestCharacter:update(dt)

    -- Tymczasowe do testu animacji
    moveX = 0
    moveY = 0
    
    if love.keyboard.isDown("w") then
        moveY = -speed * dt
        TestCharacter:setAnimationTag("Up")
	elseif love.keyboard.isDown("s") then
        moveY = speed * dt
        TestCharacter:setAnimationTag("Down")
	end
	
	if love.keyboard.isDown("a") then
        moveX = -speed * dt
        -- Zmiana tagu resetuje animacje wiec gdy są wciśnięte dwa klawisze animacja nie odtwarza się
        if not love.keyboard.isDown("w") and not love.keyboard.isDown("s") then
            TestCharacter:setAnimationTag("Left")
        end
	elseif love.keyboard.isDown("d") then
        moveX = speed * dt
        if not love.keyboard.isDown("w") and not love.keyboard.isDown("s") then
            TestCharacter:setAnimationTag("Right")
        end
    end
    
    TestCharacter:move(moveX, moveY)
    
end

function gameState:draw()
    -- Tymczasowe do testu animacji
    TestCharacter:draw()
end