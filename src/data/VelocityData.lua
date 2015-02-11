require ("lib.lclass")
require ("lib.yanecos.Data")

class "VelocityData" ("Data")

function VelocityData:VelocityData (x, y)
	self.x = x or 0
	self.y = y or 0
end

function VelocityData:x (x)
	if not x then
		return self.x
	end

	self.x = x
end

function VelocityData:y (y)
	if not y then
		return self.y
	end

	self.y = y
end
