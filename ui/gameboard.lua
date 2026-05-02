---@module "utils.constants"
local const = require("utils.constants")
---@class SizeArray
---@field x number
---@field y number
---@field w number
---@field h number


---@class GameBoard
---@field playmat_image? string
---@field bg_color? any
---@field size? SizeArray
local GameBoard = {
  bg_color=const.GLOBAL_BG_COLOR,
  playmat_image= "assets/images/default_playmat.jpg",
	size = { x=const.GAMEBOARD_X, y=const.GAMEBOARD_Y, w=const.SCREEN_WIDTH, h=const.SCREEN_HEIGHT}
}

---get the gameboard obj to draw onto the screen
---@return GameBoard

return GameBoard
