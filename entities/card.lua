---@module "utils.constants"
local const = require("utils.constants")

---@class Card
---@field name string
---@field offset number
---@field position number
---@field card_type CardType
---@field eid number --entity id
---@field image_fp string
---@field type_line string
---@field location? GameLocations
---@field x number
---@field y number
---@field w number
---@field h number

---@class Card
local Card = {}
Card.__index = Card


---@enum ManaColor
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
---@class PrintInfo
---@field foil boolean
---@field set string
---@field set_name string
---




function Card.new(
	name,
	card_type,
	eid,
	image_fp,
	type_line,
	location,
	x,
	y
)
	local self = setmetatable({}, Card)
	self.name = name
	self.card_type = card_type
	self.eid = eid
	self.image_fp = image_fp
	self.type_line = type_line
	self.location = location
	self.x = x
	self.y = y
	self.w = const.HAND_CARD_WIDTH
	self.h = const.HAND_CARD_HEIGHT
	return self
end

---lerp card upwards (linear interpolation formula)
local function lerp(a, b, t)
	return a + (b - a) * t
end

function Card:update(dt)
	local mx, my = love.mouse.getPosition()

	if mx >= self.x and mx <= self.x + self.w and my >= self.y and my <= self.y + self.h then
		self.isHovering = true
		if love.keyboard.isDown("lalt") then
			self.w = const.HAND_CARD_ZOOM_WIDTH
			self.h = const.HAND_CARD_ZOOM_HEIGHT
			self.y = const.HAND_CARD_ZOOM_Y
		else
			self.w = const.HAND_CARD_WIDTH + (const.HAND_CARD_WIDTH * 0.20)
			self.h = const.HAND_CARD_HEIGHT + (const.HAND_CARD_HEIGHT * 0.20)
			-- self.x = const.HAND_CARD_ORIGIN_X
			self.y = lerp(self.y, const.HAND_ZOOM_LERP_TARGET, dt * 7)
			-- self.x = (1 - dt) * const.HAND_CARD_ORIGIN_X + (dt + (const.HAND_CARD_HEIGHT*2))
			-- self.y = const.HAND_CARD_ORIGIN_Y - (const.SCREEN_HEIGHT*dt)
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
	self.scaleX = self.w / img_w
	self.scaleY = self.h / img_h
	love.graphics.draw(img, self.x, self.y, 0, self.scaleX, self.scaleY)
end


function Card:set_offset(offset)
end



return Card
