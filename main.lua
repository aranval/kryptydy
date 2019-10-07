function love.load()
	moveX = 300
	moveY = 300
end

function love.update(f)
	if love.keyboard.isDown("w") then
		moveY = moveY - 100 * f
	elseif love.keyboard.isDown("s") then
		moveY = moveY + 100 * f
	end
	
	if love.keyboard.isDown("a") then
		moveX = moveX - 100 * f 
	elseif love.keyboard.isDown("d") then
		moveX = moveX + 100 * f
	end
end

function love.draw()
	love.graphics.rectangle("fill", moveX, moveY, 50, 50)
end


