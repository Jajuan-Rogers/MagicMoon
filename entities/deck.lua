local request = require("http.request")
local cjson = require("cjson")

--- @class Card
--- @field id string
--- @field name string|table
--- @field count number
--- @field mana Card
--- @field image Card
--- @field type_line Card

local card = {}

--- @class Deck
--- @field owner string
--- @field deck_link string
--- @field commander string|table
--- @field num_cards  number
--- @field cards table[Card..]

local Deck = {}

function Deck.fetch_scryfall_deck(link)
	if string.find("scryfall", link, 8, true) then
		print("scryfall link is official !")
	end
	local headers, stream = assert(request.new_from_uri(link):go())
	local body = assert(stream:get_body_as_string())
end

function Deck.read_json_file(json_fp)
	local file = io.open(json_fp, "r")
	if not file then
		return nil
	end
	local contents = file:read("*a")
	file:close()
	return contents
end

local function to_card(cards)
	local no_digest = {}
	for _, val in pairs(cards) do
		if val.card_digest == cjson.null then
			local card_name = string.sub(val.raw_text, 3)
			no_digest[#no_digest + 1] = card_name
		else
			print(val.card_digest.name)
		end
	end

	if #no_digest ~= 0 then
		local n = "The 'no_digest' Key is missing for the following cards:"
		print(n)
		print(string.rep("-", #n))

		for i, val in pairs(no_digest) do
			print(i .. ") " .. val)
		end
	end
end

function Deck.parse_json_to_deck(json_fp)
	local json_data = Deck.read_json_file(json_fp)
	local deck = cjson.decode(json_data)

	Deck.cards = {}

	if not deck.in_compliance or deck.format ~= "commander" then
		print("Deck is not in complience with Commander format")
		return false
	end

	if #deck.entries.commanders > 1 then
		Deck.commander = deck.entries.commanders
	else
		Deck.commander = deck.entries.commanders[1].card_digest
	end

	Deck.nonlands = deck.entries.nonlands
	Deck.lands = deck.entries.lands
	to_card(Deck.nonlands)
	to_card(Deck.lands)
end

function Deck.output_deck_list(deck, card_type)
	local count = 0
	for _, val in pairs(deck[card_type]) do
		if val.card_digest == nil then
			goto continue
		end
		count = count + 1
		print(count .. "  " .. val.raw_text)
		::continue::
	end
end

Deck.parse_json_to_deck("/home/benten/projects/programming/lua/games/MagicMoon/test_files/my_deck.json")
-- Deck.output_deck_list(Deck, "nonlands")
-- Deck.output_deck_list(Deck, "lands")
-- print(Deck.commander.type_line)
