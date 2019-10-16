-- Do testowania na szybko
local TestSystem = libs.tiny.processingSystem()

TestSystem.filter = libs.tiny.requireAll("isTest")

function TestSystem:process(e, dt)
    e:move()
end

return TestSystem