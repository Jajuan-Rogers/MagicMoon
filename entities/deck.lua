require("paths")
---@module "entities.hand"
local Hand = require("entities.hand")

---@class Library
---@field cards Card[]
---@field commander Card
---@field tokens Card[]|Card|nil

--- @class Deck
--- @field owner Player
--- @field deck_fp string
--- @field commander? Card|Card<Card,Card>
--- @field library Library
--- @field hand Card[]
--- @field graveyard? Card[]
--- @field exiled? Card[]
--- @field tokens? Card[]
--- @field card_sleeve_img love.Image
--- @field library_size number
--- @field graveyard_size number
--- @field exiled_size number
--- @field co_task coroutinelib[]

---@class Deck
local Deck = {}
Deck.__index = Deck

---@param owner Player
---@param deck string
---@return self
function Deck.new(owner, deck)
	local self = setmetatable({}, Deck)
	self.owner = owner
	self.exiled = {}
	self.graveyard = {}
	self.co_task = {}
	self.library_size = 100
	self.graveyard_size = 0
	self.exiled_size = 0
	self.hand = Hand.new()
	return self
end

function Deck:initial_draw() end

function Deck:mullagain() end

function Deck:shuffle()
	for i = #self.library, 2, -1 do
		local rng = love.math.random(1, self.library_size)
		self.library[i], self.library[rng] = self.library[rng], self.library[i]
	end
	for i = #self.library, 2, -4 do
		local rng = love.math.random(1, self.library_size)
		self.library[i], self.library[rng] = self.library[rng], self.library[i]
	end
	print(self.owner.name .. " has shuffled there library")
end

function Deck:initial_load() end

---search for a specific card or card type then shuffle
---@param card_type any
function Deck:search_and_shuffle(card_type) end
---this is going to require me to build some menue so the player can
---visually search (scrolling through card images or names)
---or physically search (typing the name of card)

---search for a card, no post shuffle
---@param card_type any
function Deck:search(card_type) end

---put the given card back in library at random
---@param card any
function Deck:place_at_random(card) end

---put the given card(s) at the bottom of library
function Deck:put_at_bottom(card) end

return Deck
