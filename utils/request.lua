---@class ScryfallCard
---@field object string
---@field id string
---@field oracle_id string
---@field multiverse_ids integer[]
---@field mtgo_id integer|nil
---@field arena_id integer|nil
---@field tcgplayer_id integer|nil
---@field cardmarket_id integer|nil
---@field name string
---@field lang string
---@field released_at string
---@field uri string
---@field scryfall_uri string
---@field layout string
---@field highres_image boolean
---@field image_status string
---@field image_uris table<string,string>|nil
---@field mana_cost string
---@field cmc number
---@field type_line string
---@field oracle_text string|nil
---@field power string|nil
---@field toughness string|nil
---@field loyalty string|nil
---@field defense string|nil
---@field colors string[]
---@field color_identity string[]
---@field keywords string[]
---@field legalities table<string,string>
---@field games string[]
---@field reserved boolean
---@field foil boolean
---@field nonfoil boolean
---@field finishes string[]
---@field oversized boolean
---@field promo boolean
---@field reprint boolean
---@field variation boolean
---@field set_id string
---@field set string
---@field set_name string
---@field set_type string
---@field set_uri string
---@field set_search_uri string
---@field scryfall_set_uri string
---@field rulings_uri string
---@field prints_search_uri string
---@field collector_number string
---@field digital boolean
---@field rarity string
---@field flavor_text string|nil
---@field card_back_id string
---@field artist string|nil
---@field artist_ids string[]|nil
---@field illustration_id string|nil
---@field border_color string
---@field frame string
---@field frame_effects string[]|nil
---@field security_stamp string|nil
---@field full_art boolean
---@field textless boolean
---@field booster boolean
---@field story_spotlight boolean
---@field edhrec_rank integer|nil
---@field penny_rank integer|nil
---@field prices table<string,string|nil>
---@field related_uris table<string,string>|nil
---@field purchase_uris table<string,string>|nil
---@field card_faces ScryfallCardFace[]|nil
---@field all_parts table[]|nil
---@field preview table|nil
---@field produced_mana string[]|nil
---@field watermark string|nil
---@field promo_types string[]|nil
---@field variation_of string|nil
---@field life_modifier string|nil
---@field hand_modifier string|nil

---@class ScryfallCardFace
---@field name string
---@field mana_cost string|nil
---@field type_line string|nil
---@field oracle_text string|nil
---@field colors string[]|nil
---@field power string|nil
---@field toughness string|nil
---@field loyalty string|nil
---@field defense string|nil
---@field flavor_text string|nil
---@field artist string|nil
---@field image_uris table<string,string>|nil

require("paths")

local https = require("ssl.https")
local ltn12 = require("ltn12")
local json = require("cjson")

local M = {}

---@param deck_url string
function M.parse_deck_link(deck_url)
	local deck_id = deck_url:match("/decks/([%w%-_]+)")
	return deck_id
end

---reads txt file into json file of mtg card names
---the provided .txt file should only include card
---names. Do not use moxfields txt format for this
---or it will fail
---@param fp string
---@returns table|nil
function M.read_json_deck_file(fp)
  print("reading"..fp)
	local f = io.open(fp, "r")
	if not f then
		return nil
	end

	local f_data = f:read("*a")
	local json_data = json.decode(f_data)
	for k, v in pairs(json_data.entries.nonlands) do
		print(k, v.card_digest.name)
	end
  print(json_data)
  os.exit()
  return json_data
end

function M.read_txt_deck_file(fp)
	local f = io.open(fp, "r")
	if not f then
		return nil
	end

	local deck_list = { identifiers = {} }
	local commander = nil
	local on_commander_line = false

	for line in f:lines() do
		-- 1. Clean the line (strips leading/trailing whitespace and tabs)
		local clean_line = line:match("^%s*(.-)%s*$")

		if clean_line == "" then
		elseif clean_line == "Commander" or clean_line == "// Commander" then
			on_commander_line = true
		elseif clean_line:sub(1, 2) == "//" then
		else
			local count_str, name = clean_line:match("^(%d+)%s+(.+)$")

			local count = tonumber(count_str) or 1

			local card_name = name or clean_line
			---@cast card_name string

			local a = card_name:find("/", 1)
			if a then
				card_name = card_name:sub(1, a - 1)
			else
			end

			if on_commander_line then
				commander = card_name
				on_commander_line = false
			end

			for _ = 1, count do
				table.insert(deck_list.identifiers, { name = card_name })
			end
		end
	end

	f:close()

	-- Safety Check: If the file had no Commander section, do you want to abort the whole file?
	if not commander then
		print("Warning: No Commander found in file.")
		return nil -- (Uncomment this ONLY if a missing commander should break the whole import)
	end
	return deck_list, commander
end

---get deck from scryfall given a txt file
---@param fp string
---@return Card[]|nil cards
---@return nil|string #error fetching api data or parsing card file or
--- your commander was not found in file. If the commander was not found
--- be sure to copy text if using **scryfall** or copy for Arena if using
--- **moxfield**
function M.fetch_scryfall_deck(fp)
	local api_url = "https://api.scryfall.com/cards/collection"
  local deck_data
  local commander
	if fp:find(".txt", (#fp - 4)) then
		deck_data, commander = M.read_txt_deck_file(fp)
	elseif fp:find(".json", #fp - 6) then
		deck_data, commander = M.read_json_deck_file(fp)
	else
		return nil, "wrong file fomrat provided, only support for txt and json"
	end

	if deck_data == nil then
		return nil, "No commander found in deck !"
	end

	local all_ids = deck_data.identifiers
	local batch_1 = { identifiers = table.move(deck_data.identifiers, 1, 75, 1, {}) }
	local batch_2 = { identifiers = table.move(all_ids, 76, #all_ids, 1, {}) }

	local batch = { batch_1, batch_2 }

	local final_data
	for i = 1, #batch do
		local request_body = json.encode(batch[i])
		local response_chunks = {}
		local r, code, _, status = https.request({
			url = api_url,
			method = "POST",
			headers = {
				["Content-Type"] = "application/json",
				["Content-Length"] = tostring(#request_body),
				["User-Agent"] = "Magically/1.0",
				["Accept"] = "application/json",
			},
			source = ltn12.source.string(request_body),
			sink = ltn12.sink.table(response_chunks),
		})
		if code == 200 then
			local final_response = table.concat(response_chunks)
			final_data = json.decode(final_response)
			-- print("successfully recieved deck")
		else
			print("ERROR: ", tostring(code), r, tostring(status))
			print(table.concat(response_chunks))
			if i == 1 then
				print("This error occured while requesting api for 'batch_1' cards")
			else
				print("This error occured while requesting api for 'batch_2' cards")
			end
		end
		if i == 1 then
			batch_1 = final_data.data
		else
			batch_2 = final_data.data
		end
	end
	final_data = table.move(batch_2, 1, #batch_2, (#batch_1 + 1), batch_1)
	final_data.commander = commander
	return final_data
end

---get a card given its name and other optional arguments
---if you do give the other optional arguments the lieklyhood
---of that card being found decreases unless you're certain a
---card of that name, set_id, collection number and printing
---actually exist in the scyfall database
---@param name any
---@param set_id? string
---@param collection_num? string
---@param foil? boolean
function M.card_image_from_name(name, set_id, collection_num, foil) end

function M.card_image_from_uri(uri) end

---scryfall gives a lot of information with each card that we will not
---be using in the game so here is where we will make a new table with
---all cards from the loaded deck and only attach the information we need
--- - name
--- - image_type
--- - image_uri
--- - card_faces
--- - rullings_uri
--- - scryfall_uri
--- - uri
---@param cards ScryfallCard[]
---@return table
-- function M.adjust_card_tables(cards)
-- 	local nt = {}
-- 	nt.cards = {}
-- 	for i, c in ipairs(cards) do
-- 		local card = {}
-- 		card.name = c.name
-- 		if c.card_faces ~= nil then
-- 			local faces = c.card_faces
-- 			---@cast faces ScryfallCardFace
-- 			card.multi_faced = true
-- 			card.faces = {}
-- 			for k, face in ipairs(faces) do
-- 				card.faces[k] = face
-- 				print(k, face.name)
-- 			end
-- 		end
-- 	end
-- end
--
-- local d, e = M.fetch_scryfall_deck("test_files/caesar_deck.txt")
-- -- M.adjust_card_tables(d)
-- print(e)
-- for k, v in pairs(d) do
-- 	if k ~= "commander" then
-- 		print(k, v.name)
-- 	else
-- 		print(k, v)
-- 	end
-- end
--
return M
