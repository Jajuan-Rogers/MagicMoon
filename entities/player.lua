local deck = require("./deck.lua")

---@class Player
---@field name string
---@field turn number
---@field deck_name string
---@field deck Deck
---@field commander Card
---@field Hand table[Card]
local Player = {}

function Player.draw_card() end


---@param n number
function Player.scry(n) end

---@param n number
function Player.mill_card(n) end

---@param n number
function Player.exile_card(n) end

---@param to? Player|"all"
function Player.reveal_hand(to) end

function Player:mullagain() end

  
