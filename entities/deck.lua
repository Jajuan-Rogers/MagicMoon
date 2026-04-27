---@module "cjson"
require("paths")
local https = require("ssl.https")
local cjson = require("cjson")


--- @class Deck
--- @field owner Player
--- @field deck_data string
--- @field commander? Card
--- @field count? number
--- @field cards? Card[]
--- @field card_sleeve_img love.Image

---@class Deck
local Deck = {}
Deck.__index = Deck

---@param owner Player|string
---@param deck_data string
---@return nil
function Deck.new(owner, deck_data)
	local self = setmetatable({}, Deck)
	self.owner = owner
	if deck_data == nil then
		---Note assert this return value to ensure its not true
		return nil
	else
		if deck_data:find("json") ~= nil then
			self.deck_data = deck_data
			self.load_deck_file(self)
		end
	end
end

function Deck:json_to_deck()
  ---@type Card
  local card

	assert(self.deck_data ~= nil)
	local c = 1

  --get the commander(s)
  if self.deck_data.commandersCount == 1 then
    for name, info in pairs(self.deck_data.commanders) do
      print(name)
      print(("*"):rep(20))
    end
  end

	for k, v in pairs(self.deck_data.mainboard) do
    -- print(c, k, v)
		if k == "Swamp" or k == "Plains" then
			c = c + v.quantity
		else
			c = c + 1
		end
	end
end

function Deck:load_deck_file()
	local f = assert(io.open(self.deck_data, "r"))
	local f_data = f:read("*a")
	f:close()
	---Note pcall here in case of error
	self.deck_data = cjson.decode(f_data)
	self.json_to_deck(self)
end

function Deck:mullagain() end

function Deck:shuffle() end

local d = Deck
d.new("jay", "test_files/blood_rites.json")

return Deck
