local entities = {}

entities.player = require("src/entities/Player")
entities.tilemap = require("src/entities/Tilemap")
entities.gotoState = require("src/entities/TriggerGoToOtherState")

-- Test
entities.testInteractive = require("src/entities/TestInteractiveEntity")

return entities