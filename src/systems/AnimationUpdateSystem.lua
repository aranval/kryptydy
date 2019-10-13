local AnimationUpdateSystem = tiny.processingSystem()

AnimationUpdateSystem.filter = tiny.requireAll("animation")

function AnimationUpdateSystem:process(e, dt)
    e.animation:update(dt)
    if e.animationTag then
        e.animation:setTag(e.animationTag);
    end
end

return AnimationUpdateSystem

