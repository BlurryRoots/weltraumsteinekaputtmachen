require ("lib.lclass")
require ("lib.yanecos.Data")

class "ThrusterData" ("Data")

function ThrusterData:ThrusterData (thrust)
	self.thrust = thrust or 1
end

function ThrusterData:thrust (thrust)
	if not thrust then
		return self.thrust
	end

	self.thrust = thrust
end
