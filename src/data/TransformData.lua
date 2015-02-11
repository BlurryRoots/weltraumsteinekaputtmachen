require ("lib.lclass")
local d = require ("lib.inspect")
require ("lib.yanecos.Data")

class "PositionData"

function PositionData:PositionData (x, y)
	self.x = x or 1337
	self.y = y or 42
end

function PositionData:__tostring ()
	return "{" .. tostring (self.x) .. ":" .. tostring (self.y) .. "}"
end

function PositionData:X (x)
	if not x then
		return self.x
	end

	self.x = x
end

function PositionData:Y (y)
	if not y then
		return self.y
	end

	self.y = y
end
