local AnimationUpdateSystem = libs.tiny.processingSystem()

AnimationUpdateSystem.filter = libs.tiny.requireAll("animation")

function AnimationUpdateSystem:process(entity, dt)
    entity.animation:update(dt)
    if entity.animationTag then
        entity.animation:setTag(entity.animationTag);
    end
end

return AnimationUpdateSystem

