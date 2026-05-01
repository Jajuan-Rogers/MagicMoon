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


function Hand:update() end


---add card to hand
---@param card ScryfallCard
function Hand:add_card(card, eid)

	-- local game_card =
	--  Card.new(card.name, card, eid, nil,card.image_uris.png, card.type_line, "Hand", nil, const.HAND_CARD_ORIGIN_Y)
	-- self.count = self.count + 1
	-- if self.count % 2 == 0 then
	-- 	game_card.bx = const.HAND_CARD_ORIGIN_X + (150 * self.count) / 2
	-- 	game_card.x = const.HAND_CARD_ORIGIN_X + (150 * self.count) / 2
	-- else
	-- 	game_card.bx = const.HAND_CARD_ORIGIN_X - (150 * self.count) / 2
	-- 	game_card.x = const.HAND_CARD_ORIGIN_X - (150 * self.count) / 2
	-- end
	-- game_card.by = const.HAND_CARD_ORIGIN_Y
	-- table.insert(self.cards, self.count, game_card)
	-- ---when we add a card, create coroutine to fetch image from api
	-- game_card.card_png = request.card_image_from_uri(game_card.card_png, game_card.name)
	-- print("added " .. game_card.name)
	-- self.cards[game_card.name] = game_card
	-- self.cards[game_card.name].offset = const.HAND_CARD_OFFSET_X
	-- print("jay now had " .. self.count .. "card in hand")
end


function Hand:discard_card()
	self.current_card_offset = self.current_card_offset + const.HAND_CARD_OFFSET_X
end


function Hand:draw() end

---load or reload cards in hand
---@param reload? boolean
function Hand:load(reload) end

return Hand
