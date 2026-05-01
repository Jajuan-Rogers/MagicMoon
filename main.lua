require("paths")

---@module "entities.player"
local Player = require("entities.player")

---@module 'ui.gameboard'
local gameboard = require("ui.gameboard")


---@module "utils.constants"
local const = require("utils.constants")

---@type Player
local player_1 = Player.new("jay", "test_files/restless_deck.txt") --temp way of loading deck
os.exit()

---@type Player[]
local players = {}
local cardImages = {}


---players who join me or players who are in a 
---session that I join will be placed here !
table.insert(players, player_1)

function love.load()
	love.window.setMode(const.SCREEN_WIDTH, const.SCREEN_HEIGHT, { fullscreen = true, fullscreentype = "exclusive" })
	Mat = love.graphics.newImage(gameboard.playmat_image)
	local mat_w, mat_h = Mat:getDimensions()
	Mat_scaleX = const.GAMEBOARD_WIDTH / mat_w
	Mat_scaleY = const.GAMEBOARD_HEIGHT / mat_h

  --- loop through players and load in all of there cards to disk !
  --- make a player:load() function
end

function love.update(dt)
	for i = #player_1.hand.cards, 1, -1 do
		player_1.hand.cards[i]:update(dt)
		-- Optional: if one card is hovered, break so you don't hover two at once
	end
end

function love.draw(dt)
	love.graphics.setBackgroundColor(1, 1, 11, 1)
	love.graphics.rectangle("line", const.GAMEBOARD_X, const.GAMEBOARD_Y, const.GAMEBOARD_WIDTH, const.GAMEBOARD_HEIGHT)
	love.graphics.draw(Mat, const.GAMEBOARD_X, const.GAMEBOARD_Y, 0, Mat_scaleX, Mat_scaleY)
	local test_offset = 150

  ---check if there are cards chached in ram, 
  ---if they are add and they're needed add them 
  ---if a card on disk is needed get it and load it
end
