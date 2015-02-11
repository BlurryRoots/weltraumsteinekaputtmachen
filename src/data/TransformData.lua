require ("lib.lclass")
require ("lib.yanecos.Data")

class "TransformData" ("Data")

function TransformData:TransformData (x, y, rotation, scale)
	self.x = x or 42
	self.y = y or 42
	self.rotation = rotation or 0
	self.scale = scale or 1
end

function TransformData:__tostring ()
	local str = "{" .. tostring (self.x) .. ":" .. tostring (self.y) .. "}"
	str = str .. "/" .. tostring (self.rotation)
	str = str .. "@" .. tostring (100 / self.scale) .. "%"

	return str
end

function TransformData:x (x)
	if not x then
		return self.x
	end

	self.x = x
end

function TransformData:y (y)
	if not y then
		return self.y
	end

	self.y = y
end

function TransformData:rotation (rotation)
	if not rotation then
		return self.rotation
	end

	self.rotation = rotation
end

function TransformData:scale (scale)
	if not scale then
		return self.scale
	end

	self.scale = scale
end
