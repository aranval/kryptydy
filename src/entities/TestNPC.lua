local TestNPC = libs.class{
    init = function(self, x, y, animation)
        nilError("animation", animation)

        self.anim = "anim"
        self.name = "Interactive"
        self.pos = libs.vector(x or 0, y or 0)
        self.collider = classes.collider(32, 32)
        self.animation = animation
        self.animationTag = "Idle"

        self.isInteractive = true
    end,
    interact = function(self)
        print(self )
        libs.talkies.say("Position", "X: ".. self.pos.x .. ", Y: " .. self.pos.y, {
            oncomplete = function(dialog) 
                self.animationTag = "Idle"
            end
        })

        self.animationTag = "Interact"
    end
}

return TestNPC