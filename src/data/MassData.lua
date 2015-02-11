require ("lib.lclass")
require ("lib.yanecos.Data")

class "MassData" ("Data")

function MassData:MassData (mass)
	self.mass = mass or 1
end

function MassData:mass (mass)
	if not mass then
		return self.mass
	end

	self.mass = mass
end
