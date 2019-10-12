local AnimationDrawSystem = tiny.processingSystem()
AnimationDrawSystem.isDrawingSystem = true

AnimationDrawSystem.filter = tiny.requireAll("animation")

function AnimationDrawSystem:process(e, dt)
    e.animation:draw(e.pos.x, e.pos.y)
end

return AnimationDrawSystem