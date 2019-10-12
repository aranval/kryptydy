local Player = {
    name = "Player",
    x = 0, y = 0,
    collider = {
        width = 32,
        height = 32
    },    
    speed = 32*6,
    animation = assets.anim_Player,
    direction = "Up", 
    isHorizontalMove = true,
    
    
    controlable = true,
    cameraTrack = true,
}


return Player