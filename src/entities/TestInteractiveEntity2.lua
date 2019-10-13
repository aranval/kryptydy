local TestInteractiveEntity = {
    name = "Interactive",
    pos = {
        x = 0, y = 0
    },
    collider = {
        isTrigger = false,
        width = 32,
        height = 32
    },
    animation = assets.anim_InteractTest2,
    animationTag = "Idle",

    isInteractive = true
}  
return TestInteractiveEntity