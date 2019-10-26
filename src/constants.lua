local CONST = {}

CONST.cameraSpeed = 2
CONST.tileSize = 32

CONST.playerSpeed = CONST.tileSize*4
CONST.npcSpeed = CONST.tileSize*3

local inventoryMargin = 96
CONST.inventory9Patch = "Assets/9Patch/window.9.png"
CONST.inventoryWindowX = inventoryMargin
CONST.inventoryWindowY = inventoryMargin
CONST.inventoryWindowWidth = love.graphics.getWidth() - inventoryMargin * 2
CONST.inventoryWindowHeight = love.graphics.getHeight() - inventoryMargin * 2


CONST.inventoryItemsMargin = 48
CONST.inventoryItemsHeight = 32
CONST.inventoryItemSelectBoxPadding = 5

CONST.inventoryNumberOfItemXOffset = 40
CONST.inventoryNumberOfItemYOffset = 8

CONST.inventoryItemNameXOffset = CONST.inventoryNumberOfItemXOffset + 24
CONST.inventoryItemNameYOffset = 0

CONST.inventoryItemDescriptionXOffset = CONST.inventoryItemNameXOffset
CONST.inventoryItemDescriptionYOffset = CONST.inventoryItemNameYOffset + 16

return CONST