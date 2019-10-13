local systems = {}

systems.animationDrawSystem = require("src/systems/AnimationDrawSystem")
systems.animationUpdateSystem = require("src/systems/AnimationUpdateSystem")
systems.collisionSystem = require("src/systems/CollisionSystem")
systems.playerControlSystem = require("src/systems/PlayerControlSystem")
systems.tilemapDrawSystem = require("src/systems/TileMapDrawSystem")

return systems