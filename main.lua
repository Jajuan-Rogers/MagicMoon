require("paths")


---@module "entities.deck"
local Deck = require("entities.deck")

local deck = Deck
deck.new("jay", "test_files/blood_rites.json")
os.exit()

---@module 'ui.gameboard'
local gameboard = require("ui.gameboard")

---@module "utils.constants"
local const = require("utils.constants")

local Card = require("entities.card")

---@type Card
local Card_1

---@type Card
local Card_2

HALF_SCREEN_X = 960
HALF_SCREEN_Y = 840
local CARD_WIDTH = 200
local CARD_HEIGHT = CARD_WIDTH * (3.5 / 2.5) -- Results in 280

function love.load()
	love.window.setMode(const.SCREEN_WIDTH, const.SCREEN_HEIGHT, { fullscreen = true, fullscreentype = "exclusive" })
	Mat = love.graphics.newImage(gameboard.playmat_image)
	local mat_w, mat_h = Mat:getDimensions()
	Mat_scaleX = gameboard.size.w / mat_w
	Mat_scaleY = gameboard.size.h / mat_h

	Card_1 = Card.new("test", 1, 1, nil, "CREATURE", "test_00", 1, {}, nil, nil, nil, nil, "Hand", 1360, 840)
	CARD_1_IMG = love.graphics.newImage(Card_1:load())

	Card_2 = Card.new("test", 1, 1, nil, "CREATURE", "test_00", 1, {}, nil, nil, nil, nil, "Hand", 1160, 840)
	CARD_2_IMG = love.graphics.newImage("assets/images/disa.png")
end

function love.update(dt)
	Card_1:update(dt)
	Card_2:update(dt)
end

function love.draw(dt)
	local count = 0
	local rotation = 3
	love.graphics.setColor(gameboard.bg_color)
	love.graphics.rectangle("line", gameboard.size.x, gameboard.size.y, gameboard.size.w, gameboard.size.h)
	love.graphics.draw(Mat, gameboard.size.x, gameboard.size.y, 0, Mat_scaleX, Mat_scaleY)

	Card_1:draw_to_screen(CARD_1_IMG)
	Card_2:draw_to_screen(CARD_2_IMG)
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
