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
---@deprecated
function M.fetch_moxfield_deck(deck_url)
	local deck_id = M.parse_deck_link(deck_url)
	if not deck_id then
		return nil, "deck id was not found in Moxfield link !"
	end

	local api_url = "https://api2.moxfield.com/v2/decks/all" .. deck_id .. "/export"
	local response = {}

	local _, code = https.request({
		url = api_url,
		method = "GET",
		protocol = "tlsv1_3",
		headers = {
			["User-Agent"] = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36",
			["Accept"] = "application/json, text/plain, */*",
			["Accept-Language"] = "en-US,en;q=0.9",
			["Sec-Fetch-Dest"] = "empty",
			["Sec-Fetch-Mode"] = "cors",
			["Sec-Fetch-Site"] = "same-site",
			["Referer"] = "https://www.moxfield.com/",
			["Origin"] = "https://www.moxfield.com",
			["Connection"] = "keep-alive",
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

	local commander = nil
	local on_commander_line = false
	for line in f:lines() do
		if on_commander_line then
			line = line:match("^%s*(.-)%s*$")
			commander = line
			_, commander = line:match("^(%d+)%s+(.+)$")
			on_commander_line = false
			goto continue
		end

		line = line:match("^%s*(.-)%s*$")

		if line == "Commander" or line == "// Commander" then
			on_commander_line = true
			goto continue
		end

		local _, name = line:match("^(%d+)%s+(.+)$")

		if name then
			table.insert(deck_list.identifiers, { name = name })
		elseif #line > 0 then
			table.insert(deck_list.identifiers, { name = line })
		end

		::continue::
	end
	f:close()
	if commander == nil then
		return nil
	end
	return deck_list, commander
end

---get deck from scryfall given a txt file
---@param txt_fp string
---@return Card[]|nil cards
---@return nil|string #error fetching api data or parsing card file or
--- your commander was not found in file. If the commander was not found
--- be sure to copy text if using **scryfall** or copy for Arena if using
--- **moxfield**
function M.fetch_scryfall_deck(txt_fp)
	local api_url = "https://api.scryfall.com/cards/collection"
	local deck_data, commander = M.read_txt_deck_file(txt_fp)

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
			print("successfully recieved deck")
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
--
-- local d,e = M.fetch_scryfall_deck("test_files/restless_mox.txt")
-- if d == nil then
--   print(e)
-- end
-- for k,v in pairs(d) do
--   print(d[104].set_name)
--   os.exit()
--   if k == "commander" then
--     print("THE DECKS COMMANDER IS: "..v)
--     goto continue
--   end
--   print(k, v)
--     ::continue::
-- end
--
return M
