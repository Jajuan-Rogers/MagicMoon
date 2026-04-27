---@module "utils.constants"
local const = require("utils.constants")


local Card = {}
Card.__index = Card



---
---@enum ManaColor
local ManaColor = {
	RED = 1,
	GREEN = 2,
	BLUE = 3,
	BLACK = 4,
	WHITE = 5,
	COLORLESS = 6,
	GENERIC = 7,
}

---@enum CardType
local CardType = {
	CREATURE = "creature",
	LAND = "land",
	SORCERY = "sorcery",
	INSTANT = "instant",
	ENCHANTMENT = "enchantment",
	PLANESWALKER = "planeswalker",
}

---@enum GameLocations
local GameLocations = {
	BATTLEFIELD = "battlefield",
	GRAVEYARD = "graveyard",
	EXILED = "exiled",
	COMMANDER_ZONE = "commander_zone",
	LIBRARY = "library",
	HAND = "hand",
	STACK = "stack",
}

---@alias toughness number
---@alias power number

---@class PTCounter
---@field power number
---@field toughness number

---@class Mana
---@field color ManaColor
---@field num number

---@class PrintInfo
---@field foil boolean
---@field set string
---@field set_name string

---@class Card
---@field name string
---@field power? number
---@field toughness? number
---@field counters? PTCounter|nil
---@field card_type CardType
---@field scryfall_id string
---@field eid number --entity id
---@field cmc Mana[]
---@field image_link string
---@field image_fp? string|nil
---@field oracle_text string
---@field type_line string
---@field location? GameLocations
---@field x number
---@field y number
---@field w number
---@field h number

---@class Card
function Card.new(
	name,
	power,
	toughness,
	counters,
	card_type,
	scryfall_id,
	eid,
	cmc,
	image_link,
	image_fp,
	oracle_text,
	type_line,
	location,
	x,
	y
)

	local self = setmetatable({}, Card)
	self.name = name
	self.power = power
	self.toughness = toughness
	self.counters = counters
	self.card_type = card_type
	self.scryfall_id = scryfall_id
	self.eid = eid
	self.cmc = cmc
	self.image_link = image_link
	self.image_fp = image_fp
	self.oracle_text = oracle_text
	self.type_line = type_line
	self.location = location
	self.base_x = x
	self.base_y = y
	self.x = x
	self.y = y
	self.w = const.HAND_CARD_WIDTH
	self.h = const.HAND_CARD_HEIGHT
	return self
end







function Card:update(dt)
	local mx, my = love.mouse.getPosition()

	if mx >= self.x and mx <= self.x + self.w and my >= self.y and my <= self.y + self.h then
		self.isHovering = true
		if love.keyboard.isDown("lalt") then
			self.w = const.HAND_CARD_ZOOM_WIDTH
			self.h = const.HAND_CARD_ZOOM_HEIGHT
      self.x = const.HAND_CARD_ZOOM_X
			self.y = const.HAND_CARD_ZOOM_Y
		else
			self.w = const.HAND_CARD_WIDTH
			self.h = const.HAND_CARD_HEIGHT
			self.x = const.HAND_CARD_ORIGIN_X
			self.y = const.HAND_CARD_ORIGIN_Y
		end
	else
		self.isHovering = false
		self.w = const.HAND_CARD_WIDTH
		self.h = const.HAND_CARD_HEIGHT
		self.x = const.HAND_CARD_ORIGIN_X
		self.y = const.HAND_CARD_ORIGIN_Y
	end
end

function Card:load()
	self.image_fp = "assets/images/black_lotus.png"
	return self.image_fp
end

---comment
---@param img love.Image
function Card:draw_to_screen(img, offset)
	love.graphics.setColor(1, 1, 1, 1)
  local img_w, img_h = img:getDimensions()
  self.scaleX = self.w/img_w
  self.scaleY = self.h/img_h
	love.graphics.draw(img, self.x, self.y, 0, self.scaleX, self.scaleY)
end

return Card
