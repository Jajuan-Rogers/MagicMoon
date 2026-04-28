---@class Player
---@field name string
---@field turn? number
---@field deck_name? string
---@field deck? Deck
---@field commander? Card
---@field Hand? table[Card]

---@class Player
local Player = {}
Player.__index = Player

---Create a new player
---@param name string
function Player.new(name)
	local self = setmetatable({}, Player)
	self.name = name or ("player_" .. math.random(1000))
  return self
end

function Player:draw_card() end

---@param n number
function Player:scry(n) end

---@param n number
function Player:mill_card(n) end

---@param n number
function Player:exile_card(n) end

---@param to? Player|"all"
function Player:reveal_hand(to) end

function Player:mullagain() end

return Player
