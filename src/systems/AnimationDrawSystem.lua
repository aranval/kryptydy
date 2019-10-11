local AnimationDrawSystem = tiny.processingSystem(Class {})
AnimationDrawSystem.isDrawingSystem = true

AnimationDrawSystem.filter = tiny.requireAll("animation")

function AnimationDrawSystem:process(e, dt)
    e.animation:draw(e.x, e.y)
end

return AnimationDrawSystem