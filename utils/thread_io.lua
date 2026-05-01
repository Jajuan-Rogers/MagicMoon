local M = {}


function M.init()
	M.thread = love.thread.newThread("utils/request.lua")
	M.in_channel = love.thread.getChannel("in_request")
	M.out_channel = love.thread.getChannel("out_request")
  print("STARTING THREAD !")
	M.thread:start()
  if not M.thread:isRunning() then
    print("THREAD DID NOT RUN")
    os.exit()
  else
    print("THE THREAD IS RUNNING")
  end
end

---sends a request to fetch deck from url to request thread 
---@param url string
function M.request_deck_from_url(url)
  	M.in_channel:push({request_type="DECK_URL", data=url}
)
end

function M.request_deck_from_file(fp)
    print("????")
  	M.in_channel:push({request_type="DECK_FP", data=fp})
    print("PUSHED DECK")
end

function M.request_img_from_url(url)
	M.in_channel:push({request_type="CARD_IMAGE", data=url})
end

function M.fetch_response()
	local response = M.out_channel:pop()
	if response then
		return response
	end
end

function M.check_errors()
    if M.thread then
        local err = M.thread:getError()
        if err then
            print("CRITICAL THREAD ERROR: " .. err)
        end
    end
end


return M
