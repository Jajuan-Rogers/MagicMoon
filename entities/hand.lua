---@module "entities.deck"
local Deck = require("entities.deck")

---@module "utils.constants"
local const = require("utils.constants")

---@module "entities.card"
local card = require("entities.card")

---@class Hand
---@field cards? Card[]
---@field deck Card[] 
---@field current_card_offset number

---@class Hand
local Hand = {}
Hand.__index = Hand


function Hand.new(deck, offset, cards)
	local self = setmetatable({}, Hand)
  self.deck = deck.new()
  self.current_card_offset = offset or 0
  self.cards = cards or cards
  return self
end


function Hand:update()
end


function Hand:decrease_card_offset()
  self.current_card_offset = self.current_card_offset - const.HAND_CARD_OFFSET_X
end

function Hand:increase_card_offset()
  self.current_card_offset = self.current_card_offset + const.HAND_CARD_OFFSET_X
end

function Hand:draw()
  self.cards
end

