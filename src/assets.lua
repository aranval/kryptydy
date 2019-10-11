local assets = { paths = {} }

love.graphics.setDefaultFilter("nearest", "nearest")

assets.anim_Player =  peachy.new("Assets/Animations/PlayerAnim.json", love.graphics.newImage("Assets/Animations/PlayerAnim.png"), "Up")

return assets
