local assets = {}

love.graphics.setDefaultFilter("nearest", "nearest")

assets.anim_Player = libs.peachy.new("Assets/Animations/Player.json", love.graphics.newImage("Assets/Animations/Player.png"), "Idle")
assets.anim_InteractTest1 = libs.peachy.new("Assets/Animations/Interact.json", love.graphics.newImage("Assets/Animations/Interact.png"), "Idle")
assets.anim_InteractTest2 = libs.peachy.new("Assets/Animations/Interact.json", love.graphics.newImage("Assets/Animations/Interact.png"), "Idle")
assets.anim_InteractTest3 = libs.peachy.new("Assets/Animations/Interact.json", love.graphics.newImage("Assets/Animations/Interact.png"), "Idle")

return assets
