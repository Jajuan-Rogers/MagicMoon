require("paths")

---@module "utils.thread_io"
local request = require("utils.thread_io")
request.init()

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
--- @field library_size number
--- @field graveyard_size number
--- @field exiled_size number

---@class Deck
local Deck = {}
Deck.__index = Deck

---@param deck_fp string
---@param deck_url? string scryfall support only (for now)
function Deck:download_new_deck(deck_fp, deck_url)
	if deck_fp then
		local f = io.open(deck_fp, "r")
		if not f then
			return nil, "That file does not exist"
		elseif f and deck_fp:find(".json", -5) then
			--- FINISH let user know using plain txt will load basic cards
			--- they can load custom prints using moxfield txt or even better
			--- json
		end
	end
	print("ABOUT TO SEND THREAD REQ", deck_fp)
	request.request_deck_from_file(deck_fp)
	print("SENT THREAD REQ")
end

---@param owner Player
---@param deck_fp string
---@return self
function Deck.new(owner, deck_fp)
	local self = setmetatable({}, Deck)
	self.owner = owner
	if deck_fp:find("txt") ~= nil then
		local d = self:download_new_deck(deck_fp)
		local resp
		while true do
			resp = request:fetch_response()
			if resp ~= nil then
				break
			end
		end
		print("GOT THE DATA, CLOSING APP IN A SEC")
		for k, v in pairs(resp) do
			print(k,v.id)
		end
		os.exit()
	end
	-- 	self.deck_fp = deck_fp
	-- 	self:shuffle()
	-- 	---assert that table is not empty
	-- 	self.commander = self.library.commander
	-- else
	-- 	--- notification system here !
	-- 	print(".TXT Files only !!")
	-- 	os.exit()
	-- end
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
