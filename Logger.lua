--[[
Copyright © [2023] [Flash_Hit a/k/a Bree_Arnold]
All Rights Reserved.
--]]

local Logger = {}
local Settings = require("__shared/submodules/LoggingClass/LoggerSettings")

function Logger.debug(class, message, ...)
	if not Settings.debugEnabled then return end
	if not Settings.categories[class._cat] and not Settings.classes[class._name] then return end

	if type(message) == "string" then
		message = string.format(message, ...)
		print(string.format("[%s] DEBUG: %s", class._name, message))
	elseif type(message) == "table" then
		print(string.format("[%s] DEBUG:", class._name))
		print(message)
	else
		error("Wrong usage of debug logs.")
	end
end

function Logger.info(class, message, ...)
	if type(message) == "string" then
		message = string.format(message, ...)
		print(string.format("[%s] INFO: %s", class._name, message))
	elseif type(message) == "table" then
		print(string.format("[%s] INFO:", class._name))
		print(message)
	else
		error("Wrong usage of info logs.")
	end
end

function Logger.warn(class, message, ...)
	if type(message) == "string" then
		message = string.format(message, ...)
		print(string.format("[%s] WARNING: %s", class._name, message))
	elseif type(message) == "table" then
		print(string.format("[%s] WARNING:", class._name))
		print(message)
	else
		error("Wrong usage of warning logs.")
	end
end

function Logger.error(class, message, ...)
	if type(message) == "string" then
		message = string.format(message, ...)
		-- TODO: remove print once error messages work in all cases again.
		-- (currently in callback of async http requests it doesn't work.)
		print(string.format("[%s] ERROR: %s", class._name, message))
		error(string.format("[%s] %s", class._name, message))
	else
		error("Wrong usage of error logs.")
	end
end

return Logger
