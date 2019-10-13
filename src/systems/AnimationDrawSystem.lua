local AnimationDrawSystem = libs.tiny.processingSystem()
AnimationDrawSystem.isDrawingSystem = true

AnimationDrawSystem.filter = libs.tiny.requireAll("animation")

function AnimationDrawSystem:process(e, dt)
    e.animation:draw(e.pos.x, e.pos.y)
end

return AnimationDrawSystem