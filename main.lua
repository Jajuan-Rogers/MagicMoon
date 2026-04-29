require("paths")

---@module "entities.player"
local Player = require("entities.player")

---@module 'ui.gameboard'
local gameboard = require("ui.gameboard")

---@module "utils.constants"
local Card = require("entities.card")

---@module "utils.constants"
local const = require("utils.constants")

---@type Player
local player_1 = Player.new("jay")

---@type Player[]
local players = {}
local cardImages = {}

table.insert(players, player_1)

function love.load()
	love.window.setMode(const.SCREEN_WIDTH, const.SCREEN_HEIGHT, { fullscreen = true, fullscreentype = "exclusive" })
	Mat = love.graphics.newImage(gameboard.playmat_image)
	local mat_w, mat_h = Mat:getDimensions()
	Mat_scaleX = const.GAMEBOARD_WIDTH / mat_w
	Mat_scaleY = const.GAMEBOARD_HEIGHT / mat_h

	for p = 1, #players do
		local player = players[p]
		local cards = player.hand.cards
		for c = 1, #cards do
			local card = cards[c]
			cardImages[card.name] = love.graphics.newImage(cards[card].image_fp)
			print("image for: " .. card.name .. " loaded")
		end
	end
end

function love.update(dt) end

function love.draw(dt)
	love.graphics.setBackgroundColor(gameboard.bg_color)
	love.graphics.rectangle("line", const.GAMEBOARD_X, const.GAMEBOARD_Y, const.GAMEBOARD_WIDTH, const.GAMEBOARD_HEIGHT)
	love.graphics.draw(Mat, const.GAMEBOARD_X, const.GAMEBOARD_Y, 0, Mat_scaleX, Mat_scaleY)
	for i, c in ipairs(cardImages) do
		love.graphics.draw(cardImages[i], const.HAND_CARD_ORIGIN_X, const.HAND_CARD_ORIGIN_Y, 0)
	end
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
