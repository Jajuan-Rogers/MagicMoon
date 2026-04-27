---@module 'ui.gameboard'
local gameboard = require("ui.gameboard")

---@module "entities.card"
local Card = require("entities.card")

---@type Card
local Card_1

HALF_SCREEN_X = 960
HALF_SCREEN_Y = 840
local CARD_WIDTH = 200
local CARD_HEIGHT = CARD_WIDTH * (3.5 / 2.5) -- Results in 280

function love.load()
	love.window.setMode(1920, 1080, { fullscreen = true, fullscreentype = "exclusive" })
	Mat = love.graphics.newImage(gameboard.playmat_image)
	local mat_w, mat_h = Mat:getDimensions()
	Mat_scaleX = gameboard.size.w / mat_w
	Mat_scaleY = gameboard.size.h / mat_h
	Card_1 = Card.new( "test", 1, 1,
		nil, "CREATURE", "test_00",
		1, {}, nil, nil, nil, nil,
		"Hand", 960, 840)
  CARD_1_IMG = love.graphics.newImage(Card_1:load())
end

function love.update(dt)
  Card_1:update(dt)
end

function love.draw(dt)
	local count = 0
	local rotation = 3
	love.graphics.setColor(gameboard.bg_color)
	love.graphics.rectangle("line", gameboard.size.x, gameboard.size.y, gameboard.size.w, gameboard.size.h)
	love.graphics.draw(Mat, gameboard.size.x, gameboard.size.y, 0, Mat_scaleX, Mat_scaleY)

  Card_1:draw_to_screen(CARD_1_IMG)
end

--increment the color of an object
--@param channel ColorChannel
-- local function inc_color_val(channel, dt)
-- 	if channel.frwd then
-- 		channel.val = channel.val + (channel.inc * dt)
-- 	else
-- 		channel.val = channel.val - (channel.inc * dt)
-- 	end
--
-- 	if channel.val >= 1.5 and channel.frwd then
-- 		channel.frwd = false
-- 	elseif channel.val <= 0.0 and not channel.frwd then
-- 		channel.frwd = true
-- 	end
-- 	return channel.val
-- end
--
-- function love.update(dt)
-- 	-- Increase the angle over time (multiplied by speed)
-- 	angleOffset = angleOffset + (1 * dt)
-- 	r = inc_color_val(r_channel,dt)
-- 	g = inc_color_val(g_channel,dt)
-- 	b = inc_color_val(b_channel,dt)
-- end
--
