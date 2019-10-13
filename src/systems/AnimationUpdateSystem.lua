local AnimationUpdateSystem = libs.tiny.processingSystem()

AnimationUpdateSystem.filter = libs.tiny.requireAll("animation")

function AnimationUpdateSystem:process(e, dt)
    e.animation:update(dt)
    if e.animationTag then
        e.animation:setTag(e.animationTag);
    end
end

return AnimationUpdateSystem

