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
	STACK = "stack"
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
---@field power number
---@field toughness number
---@field counters PTCounter|nil
---@field card_type CardType
---@field scryfall_id string
---@field eid number --entity id
---@field cmc Mana[]
---@field image_link string
---@field image_fp string
---@field oracle_text string
---@field type_line string
---@field location GameLocations
