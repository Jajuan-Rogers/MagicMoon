---@module "utils.constants"
local const = require("utils.constants")
---@class SizeArray
---@field x number
---@field y number
---@field w number
---@field h number

---@class RGBa
---@field r? number
---@field g? number
---@field b? number
---@field a? number

---@class GameBoard
---@field playmat_image? string
---@field bg_color? RGBa
---@field size? SizeArray
local GameBoard = {
  bg_color= {3,49,140,1},
  playmat_image= "assets/images/default_playmat.jpg",
	size = { x=830, y=30, w=const.SCREEN_WIDTH-830, h=const.SCREEN_HEIGHT-30}
}

---get the gameboard obj to draw onto the screen
---@return GameBoard

return GameBoard
