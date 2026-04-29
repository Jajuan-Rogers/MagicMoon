
---@module "utils.constants"
local const = require("utils.constants")

---@module "entities.card"
local Card = require("entities.card")

---@class Hand
---@field cards Card[]
---@field count number
---@field last_count number

---@class Hand
local Hand = {}
Hand.__index = Hand


---create hand object, (THIS MUST ALWAYS BE CREATED AFTER PLAYER
---AND IMMEDIATELY CONNECTED TO A PLAYER !)
---@return Hand
function Hand.new()
	local self = setmetatable({}, Hand)
  self.count = 0
  self.last_count = 0
  self.cards = {}

  return self
end



function Hand:update()
end

---add card to hand
---@param card Card
function Hand:add_card(card)
  self.cards[card.name] = card
  self.cards[card.name].offset = const.HAND_CARD_OFFSET_X
end

function Hand:discard_card()
  self.current_card_offset = self.current_card_offset + const.HAND_CARD_OFFSET_X
end

function Hand:draw()
end

return Hand
