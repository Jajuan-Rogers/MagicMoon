require("paths")

local request = require("utils.request")
local Player = require("entities.player")


---@module "cjson"
local cjson = require("cjson")

--- @class Deck
--- @field owner Player
--- @field deck_fp string
--- @field commander? Card
--- @field count? number
--- @field cards? Card[]
--- @field card_sleeve_img love.Image

---@class Deck
local Deck = {}
Deck.__index = Deck

---@param owner Player
---@param deck_fp string
---@return nil
function Deck.new(owner, deck_fp)
	local self = setmetatable({}, Deck)
	self.owner = owner
	if deck_fp == nil then
		---Note assert this return value to ensure its not true
		return nil
	else
		if deck_fp:find("json") ~= nil then
			self.deck_fp = deck_fp
      -- request.fetch_scryfall_deck(deck_fp)
		end
	end
end

function Deck:json_to_deck()
end

function Deck:mullagain() end

function Deck:shuffle() end

local d = Deck

local p = Player.new("jay")

d.new(p, "test_files/blood_rites.json")

return Deck
