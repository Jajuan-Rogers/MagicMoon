-- paths.lua
local version = _VERSION:match("%d+%.%d+") or "5.4"

-- Add the local lua_modules folder to the search paths
package.path = package.path .. ";./lua_modules/share/lua/" .. version .. "/?.lua"
package.path = package.path .. ";./lua_modules/share/lua/" .. version .. "/?/init.lua"

-- Add support for C-modules (.so for Mac/Linux, .dll for Windows)
package.cpath = package.cpath .. ";./lua_modules/lib/lua/" .. version .. "/?.so"
package.cpath = package.cpath .. ";./lua_modules/lib/lua/" .. version .. "/?.dll"
