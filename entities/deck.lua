local request = require("http.request")
local cjson = require("cjson")

---@class Cards
---@field card table[Card]

--- @class Card
--- @field id string
--- @field name string|table
--- @field mana string
--- @field image string
--- @field type string

local card = {}

--- @class Deck
--- @field owner string
--- @field deck_link string
--- @field commander string|table
--- @field num_cards  number
--- @field cards table[Card]

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

--- take json array of cards turn them into card
--- objects return table of each card
---@param json_cards table
---@return table[Cards]
local function to_card(json_cards)
	---@type table[Card]
	local cards = {}

	local no_digest = {}
	for _, val in pairs(json_cards) do
		if val.card_digest == cjson.null then
			local card_name = string.sub(val.raw_text, 3)
			no_digest[#no_digest + 1] = card_name
		else
			---@type Card
			card = {
				id = val.card_digest.id,
				name = val.card_digest.name,
				image = val.card_digest.image_uris.front,
				mana = val.card_digest.mana_cost,
				type = val.card_digest.type,
			}
      cards[#cards+1] = card
      print(cards)
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
	print("\n\n")
	return cards
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
		if val.card_digest == cjson.null then
			goto continue
		end
		count = count + 1
		print(count .. "  " .. val.raw_text)
		::continue::
	end
end


--- get the card image via scryfall api
---@param card_name string
---@param save_fp string|nil
---@param image_url string
local function get_card_img(card_name, image_url, save_fp)
	os.execute("curl -s " .. image_url .. " --output " .. save_fp)
  print(card_name)
  print(("-"):rep(#card_name))
	os.execute("kitty icat " .. save_fp)
end

Deck.parse_json_to_deck("/home/benten/projects/programming/lua/games/MagicMoon/test_files/my_deck.json")
print(Deck.cards.name)
-- local url = Deck.cards[5].image
-- local name= Deck.cards[5].name
-- local save_fp = "/home/benten/projects/programming/lua/games/MagicMoon/test_files/my_card.jpg"
-- get_card_img(name,url , save_fp)
-- Deck.output_deck_list(Deck, "nonlands")
-- Deck.output_deck_list(Deck, "lands")
-- print(Deck.commander.type_line)
