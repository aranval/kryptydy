local AnimationUpdateSystem = tiny.processingSystem(Class {})

AnimationUpdateSystem.filter = tiny.requireAll("animation")

function AnimationUpdateSystem:process(e, dt)
    e.animation:update(dt)
    e.animation:setTag(e.direction);
end

return AnimationUpdateSystem

