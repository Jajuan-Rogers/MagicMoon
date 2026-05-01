local Hand = require("entities.hand")

local Deck = require("entities.deck")
math.randomseed(os.time())
---
---
---@class Player
---@field name string
---@field turn? number
---@field health? number
---@field deck_name? string
---@field deck Deck
---@field commander? Card
---@field mullagans_count number
---@field hand Hand

---@class Player
local Player = {}
Player.__index = Player

---Create a new player
---@param name string
---@param selected_deck string --the name of a deck folder sitting in the games decks/ dir
function Player.new(name, selected_deck)
	local self = setmetatable({}, Player)
	self.name = name or ("player_" .. math.random(1000))
	self.deck = Deck.new(self, selected_deck) --se
	self.hand = Hand.new()
	self.health = 40
	self.mullagans_count = 0
	self:initial_card_draw()
	return self
end

function Player:initial_card_draw()
	for _ = 1, 7 do
		local rng = love.math.random(1, #self.deck.library)
		self.hand:add_card(self.deck.library[rng], rng)
		table.remove(self.deck.library, rng)
	end
end


function Player:amount()

end


---@param n number
function Player:scry(n) end


---player draw n amount of cards default is 1
---@param n? number
function Player:draw_card(n)
	if not n then n = 1 end
  local card
	for i = 1, n do
		card = self.deck.library[i]
		local eid = card.eid
		self.hand:add_card(self.deck.library[i], eid)
    table.remove(self.deck.library, i)
	end
  return card.name
end

---@param n number
function Player:mill_card(n) end

---player will exile a card from there library at rangom
---@param n number
function Player:exile_card(n) end

function Player:exile_target_card(n) end

function Player:exile_hand_card(n) end
---@param to? Player|"all"
function Player:reveal_hand(to) end

function Player:mullagans()
	if self.mullagans_count == 7 then
		self.health = 0
	end
	for _ = 1, 7 - self.mullagans_count do
		self:initial_card_draw()
	end
end

return Player
