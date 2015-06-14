require ("lib.lclass")
require ("lib.yanecos.Processor")

class "MovementProcessor" ("Processor")

function MovementProcessor:MovementProcessor (entityManager)
	self.em = entityManager
end

function MovementProcessor:onUpdate (dt)
	local entities = self.em:findEntitiesWithData ({
		TransformData:getClass (),
		VelocityData:getClass ()
	})

	for _, eid in pairs (entities) do
		local transform = self.em:getData (eid, TransformData:getClass ())
		local velocity = self.em:getData (eid, VelocityData:getClass ())

		transform.x = transform.x + (velocity.x * dt)
		transform.y = transform.y + (velocity.y * dt)
	end
end
