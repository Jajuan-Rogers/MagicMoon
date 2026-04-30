require("paths")

local request = require("utils.request")

---@module "cjson"
local cjson = require("cjson")

---@class Library
---@field cards Card[]
---@field commander Card
---@field tokens Card[]|Card|nil

--- @class Deck
--- @field owner Player
--- @field deck_fp string
--- @field commander? Card|Card<Card,Card>
--- @field library Library
--- @field graveyard? Card[]
--- @field exiled? Card[]
--- @field tokens? Card[]
--- @field card_sleeve_img love.Image

---@class Deck
local Deck = {}
Deck.__index = Deck

---@param owner Player
---@param deck_fp string
---@return self
function Deck.new(owner, deck_fp)
	local self = setmetatable({}, Deck)
	self.owner = owner
	if deck_fp:find("txt") ~= nil then
		self.deck_fp = deck_fp
		self.library = request.fetch_scryfall_deck(deck_fp) or {}

		---assert that table is not empty
		---

		self.normalize_library_data(self)
		self.commander = self.library.commander
	else
		--- notification system here !
		print(".TXT Files only !!")
		os.exit()
	end
	return self
end


function Deck:initial_draw() end

function Deck:mullagain() end

function Deck:shuffle() end

---search for a specific card or card type then shuffle
---@param card_type any
function Deck:search_and_shuffle(card_type) end

---search for a card, no post shuffle
---@param card_type any
function Deck:search(card_type) end

---put the given card back in library at random
---@param card any
function Deck:place_at_random(card) end

---put the given card(s) at the bottom of library
function Deck:put_at_bottom(card) end

-- local d = Deck
--
-- local p = Player.new("jay")
--
-- d.new(p, "test_files/restless_scryfall.txt")
--
return Deck
