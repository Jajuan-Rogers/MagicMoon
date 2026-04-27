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
	size = { x=430, y=10, w=1480, h=1060 }
}

---get the gameboard obj to draw onto the screen
---@return GameBoard

return GameBoard
