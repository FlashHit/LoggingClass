--[[
Copyright (c) [2023] [Flash_Hit a/k/a Bree_Arnold]

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
--]]

---@class Class
---@field debug function
---@field info function
---@field warn function
---@field error function
---@field _name string
---@field _cat any
---@overload fun(name: string, cat: any):Class
Class = {}

function Class.new(name, cat)
	if _G[name] then
		error(string.format("Class with the name '%s' exists already.", name))
		return
	end

	---@module "Shared.submodules.LoggingClass.Logger"
	local Logger = require("__shared/submodules/LoggingClass/Logger")

	local static = {
		_name = name,
		_cat = cat or "undefined"
	}

	for l_Name, l_Function in pairs(Logger) do
		static[l_Name] = l_Function
	end

	static.__init = function(self, ...) return self end

	setmetatable(static, {
		__call = function(self, ...)
			local instance = {}
			setmetatable(instance, { __index = static })
			return self.__init(instance, ...) or instance
		end
	})

	_G[name] = static
	return static
end

---@diagnostic disable-next-line: param-type-mismatch
setmetatable(Class, { __call = function(self, ...) return Class.new(...) end })
