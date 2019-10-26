local AnimationDrawSystem = libs.tiny.processingSystem(libs.class{})
AnimationDrawSystem.isDrawingSystem = true

AnimationDrawSystem.filter = libs.tiny.requireAll("animation")

function AnimationDrawSystem:process(entity, dt)
    entity.animation:draw(entity.position.x, entity.position.y)
end

return AnimationDrawSystem