local angleOffset = 0
local r, g, b = 0, 0, 0
local z = 10
local r_channel = { val = r, inc = 0.9, frwd = true }
local g_channel = { val = g, inc = 0.3, frwd = true }
local b_channel = { val = b, inc = 0.7, frwd = true }


--
-- function love.load()
-- 	-- You can also set/reset values here when the game starts
-- 	angleOffset = 0
-- end
--
local function inc_size_val(var, inc, forward, back)
	if forward then
		var = var + inc
	else
		var = var - inc
	end

	if var >= 30 and forward then
		back = true
		forward = false
	elseif var <= 10 and back then
		forward = true
		back = false
	end
	return var, forward, back
end

---increment the color of an object
---@param channel ColorChannel
local function inc_color_val(channel, dt)
	if channel.frwd then
		channel.val = channel.val + (channel.inc * dt)
	else
		channel.val = channel.val - (channel.inc * dt)
	end

	if channel.val >= 1.5 and channel.frwd then
		channel.frwd = false
	elseif channel.val <= 0.0 and not channel.frwd then
		channel.frwd = true
	end
	return channel.val
end

function love.update(dt)
	-- Increase the angle over time (multiplied by speed)
	angleOffset = angleOffset + (1 * dt)
	r = inc_color_val(r_channel,dt)
	g = inc_color_val(g_channel,dt)
	b = inc_color_val(b_channel,dt)
end

function love.draw()
	love.graphics.push() -- Save current state
	love.graphics.translate(400, 300) -- Move "0,0" to the screen center
	love.graphics.rotate(angleOffset) -- Rotate the entire coordinate system
	for i = 1, 8 do
		local angle = (i / 8) * (math.pi * 2)
		local x = math.cos(angle) * 100
		local y = math.sin(angle) * 100
		love.graphics.setColor(r , g , b , 1)
		if i % 2 == 0 then
			love.graphics.circle("fill", x, y*r, z)
		else
			love.graphics.circle("fill", x, y*b, z)
		end
	end
	love.graphics.pop() -- Restore state so other things don't rotate
end
