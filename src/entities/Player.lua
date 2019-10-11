local Player = {
    x = 0, y = 0,
    speed = 96,
    animation = assets.anim_Player,
    direction = "Up", 
    isHorizontalMove = true,
    
    controlable = true,
    cameraTrack = true
}


return Player