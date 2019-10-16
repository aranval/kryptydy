local entities = {}

entities.tileCollider = require("src/entities/TileCollider")
entities.player = require("src/entities/Player")
entities.tilemap = require("src/entities/Tilemap")
entities.gotoState = require("src/entities/TriggerGoToOtherState")

-- Test
entities.testNPC = require("src/entities/TestNPC")

return entities