require("paths")

local https = require("ssl.https")
local ltn12 = require("ltn12")
local json = require("cjson")

local M = {}

---@param link string
function M.parse_deck_link(deck_url)
	local deck_id = link:match("/decks/([%w%-_]+)")
	return deck_id
end

function M.fetch_moxfield_deck(deck_url)
	local deck_id = M.parse_deck_link(deck_url)
	if not deck_id then
		return nil, "deck id was not found in Moxfield link !"
	end

	local api_url = "https:://api.moxfield.com/v2/decks/all" .. deck_id
	local response = {}

	local _, code = https.request({
		url = api_url,
		method = "GET",
		headers = {
			["User-Agent"] = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36",
			["Accept"] = "application/json",
		},

		sink = ltn12.sink.table(response),
	})

	if code ~= 200 then
		return nil, "API request failed with HTPP status code: " .. tostring(code)
	end

	local raw_json = table.concat(response)

	local success, parsed_deck = pcall(json.decode, raw_json)

	if success then
		return parsed_deck
	else
		return nil, "Failed to decode the JSON response"
	end
end

---reads txt file into json file of mtg card names
---the provided .txt file should only include card
---names. Do not use moxfields txt format for this
---or it will fail
---@param fp string
---@returns table|nil
function M.read_txt_deck_file(fp)
	local f = io.open(fp, "r")
	if not f then
		return nil
	end

	local deck_list = { identifiers = {} }

	for line in f:lines() do
		line = line:match("^%s*(.-)%s*$")

		local qty, name = line:match("^(%d+)%s+(.+)$")

		if name then
			table.insert(deck_list.identifiers, { name = name })
		elseif #line > 0 then
			table.insert(deck_list.identifiers, { name = line })
		end
	end
	f:close()
	return deck_list
end

---get deck from scryfall given a txt file
---@param txt_fp string
---@return table|nil
function M.fetch_scryfall_deck(txt_fp)
	local api_url = "https://api.scryfall.com/cards/collection"
	local deck_data = M.read_txt_deck_file(txt_fp)

	if deck_data == nil then
		return nil
	end

	local all_ids = deck_data.identifiers
	local chunk_1 = { identifiers = table.move(deck_data.identifiers, 1, 75, 1, {}) }
	local chunk_2 = { identifiers = table.move(all_ids, 76, #all_ids, 1, {}) }
	local chunks = { chunk_1, chunk_2 }

	local final_data
	for i = 1, #chunks do
		local request_body = json.encode(chunks[i])
		local response_chunks = {}
		local r, code, headers, status = https.request({
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
			print("successfully recieved deck")
		else
			print("ERROR: ", tostring(code), r, tostring(status))
			print(table.concat(response_chunks))
		end
    if i == 1 then
      chunk_1 = final_data
    else
      chunk_2 = final_data
    end
	end
	final_data = table.move(chunks[2], 1, #chunks[2], #chunks[1] + 1, chunk_1)

	for k, v in pairs(final_data.data) do
		print(k, v.name)
	end
	os.exit()
	return final_data
end

local d = M.fetch_scryfall_deck("test_files/blood_rites.txt")

for a, b in pairs(d.data) do
	print(a, b.name, b.set, b.finish)
end
