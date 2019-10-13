local assets = {}

love.graphics.setDefaultFilter("nearest", "nearest")

assets.anim_Player =  peachy.new("Assets/Animations/Player.json", love.graphics.newImage("Assets/Animations/Player.png"), "Up")
assets.anim_InteractTest1 =  peachy.new("Assets/Animations/Interact.json", love.graphics.newImage("Assets/Animations/Interact.png"), "Idle")
assets.anim_InteractTest2 =  peachy.new("Assets/Animations/Interact.json", love.graphics.newImage("Assets/Animations/Interact.png"), "Idle")
assets.anim_InteractTest3 =  peachy.new("Assets/Animations/Interact.json", love.graphics.newImage("Assets/Animations/Interact.png"), "Idle")

return assets
