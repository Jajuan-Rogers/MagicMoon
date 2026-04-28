---@module "entities.deck"
local Deck = require("entities.deck")

---@module "utils.constants"
local const = require("utils.constants")

---@module "entities.card"
local card = require("entities.card")

---@class Hand
---@field owner string
---@field cards? Card[]
---@field deck Card[] 
---@field current_card_offset number

---@class Hand
local Hand = {}
Hand.__index = Hand


---create hand object, (THIS MUST ALWAYS BE CREATED AFTER PLAYER
---AND IMMEDIATELY CONNECTED TO A PLAYER !)
---@param cards Card[]
---@param owner string
---@return Hand
function Hand.new(deck, offset, cards, owner)
	local self = setmetatable({}, Hand)
  self.deck = deck.new()
  self.current_card_offset = offset or 0
  self.cards = cards or cards
  return self
end


function Hand:update()
end

function Hand:draw_card()
end

function Hand:discard_card()
  self.current_card_offset = self.current_card_offset + const.HAND_CARD_OFFSET_X
end

function Hand:draw()
end

