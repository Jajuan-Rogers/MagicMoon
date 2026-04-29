local Hand = require("entities.hand")
local Deck = require("entities.deck")
---
---
---@class Player
---@field name string
---@field turn? number
---@field deck_name? string
---@field deck Deck
---@field commander? Card
---@field hand Hand

---@class Player
local Player = {}
Player.__index = Player

---Create a new player
---@param name string
function Player.new(name)
	local self = setmetatable({}, Player)
	self.name = name or ("player_" .. math.random(1000))
	self.deck = Deck.new(self, "test_files/restless_scryfall.txt")
	self.hand = Hand.new()
  for k,v in pairs(self.deck) do
    if k == "library" then
    print(k,v.cards)
  end
end
  os.exit()
	-- for _ = 1, 7 do
	-- 	self.draw_card(self)
	-- end
	return self
end

function Player:draw_card()
	local rng = math.random(100)
  os.exit()
	self.hand.add_card(self, self.deck[rng])
end

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
