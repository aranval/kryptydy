local Player = {
    name = "Player",
    isPlayer = true,
    pos = {
        x = 0,
        y = 0
    },
    collider = {
        isTrigger = false,
        width = 32,
        height = 32
    },    
    speed = 32*5,
    animation = assets.anim_Player,
    direction = "Up", 
    isHorizontalMove = true,
    
    controlable = true
}


return Player