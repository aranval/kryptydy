local CONST = {}

CONST.menuFont = "Assets/Fonts/Pixel UniCode.ttf"
CONST.menuFontSize = 48
CONST.menuMargin = 25
CONST.menuMarginBetweenOptions = 5
CONST.menuControlsMarginBetween = 5
CONST.menuControlsMarginTop = 50
CONST.menuControlsMarginLeft = 10

CONST.battleFont = "Assets/Fonts/Pixel UniCode.ttf"
CONST.battleFontSize = 24
CONST.talkiesFont = "Assets/Fonts/Pixel UniCode.ttf"
CONST.talkiesFontSize = 24
CONST.gameOverFont = "Assets/Fonts/Pixel UniCode.ttf"
CONST.gameOverFontBigSize = 119
CONST.gameOverFontSize = 48

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