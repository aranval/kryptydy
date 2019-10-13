local TriggerGoToOtherState = libs.class{
    init = function(self, x, y, stateTable)
        nilError("stateTable", stateTable)

        self.name = "GoToOtherState"
        self.stateTable = stateTable
        self.pos = libs.vector(x, y)
        self.collider = classes.collider(32, 32, true)
        self.isGoto = true
    end
}
return TriggerGoToOtherState