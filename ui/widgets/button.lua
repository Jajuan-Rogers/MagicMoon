---@class ButtonStyle
---@field text_color RGBa
---@field font string
---@field font_size number
---@field bg_color number
---@field border_color number

---@class RGBa
---@field r number
---@field g number
---@field b number
---@field a number

---@class Button
---@field isHovering boolean
---@field clicked love.Event
---@field isClickable boolean
---@field size table<number,number>
---@field pos table<number,number>
---@field callbacks function[]
---@field current_style ButtonStyle
---@field base_style ButtonStyle
---@field hover_style ButtonStyle
---@field clicked_style ButtonStyle

local Button = {}
Button.__index = Button

---create a new button
---@param isClickable? boolean default = true
---@param callbacks function|function[] function(s) to be called when button is clicked
---@param base_style? ButtonStyle
---@param hover_style? ButtonStyle
---@param clicked_style? ButtonStyle
---@return self
function Button.new(isClickable, callbacks, base_style, hover_style, clicked_style)
	local self = setmetatable({}, Button)
	self.isClickable = isClickable
	self.base_style = base_style
	self.current_style = base_style
	self.hover_style = hover_style
	self.clicked_style = clicked_style
	self.callbacks = callbacks
  self.clicked = false
	return self
end

function Button:load() end

function Button:clicked() end
function Button:Update()
	local mx, my = love.mouse.getPosition()
	if mx >= self.x and mx <= self.x + self.w and my >= self.y and my <= self.y + self.h then
		self.isHovering = true
		self.current_style = self.hover_style
	elseif
		mx >= self.x
		and mx <= self.x + self.w
		and my >= self.y
		and my <= self.y + self.h
		and love.mouse.isDown(1)
    and self.isClickable
	then
		self.current_style = self.clicked_style
    self.clicked = true
	end
end
