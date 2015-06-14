require ("lib.lclass")
require ("lib.yanecos.Processor")

require ("src.events.FireMissileEvent")

class "MissileProcessor" ("Processor")

function MissileProcessor:MissileProcessor (entityManager)
	self.em = entityManager
	self.missilesToBeFired = 0

	self.reactions = {
		FireMissileEvent =  function ()
			self.missilesToBeFired = self.missilesToBeFired + 1
		end
	}

	self.missileSpeed = 512
end

function MissileProcessor:onUpdate (dt)
	self:despawnMissiles (dt)
	self:spawnMissiles (dt)
end

function MissileProcessor:despawnMissiles (dt)
	-- despawn out of bound missiles
	local missiles = self.em:findEntitiesWithTag ({"missile"})

	for _, missile in pairs (missiles) do
		local transform = self.em:getData (missile, TransformData:getClass ())

		if transform.x > love.graphics.getWidth ()
		or transform.y > love.graphics.getHeight ()
		or transform.x < 0
		or transform.y < 0 then
			self.em:deleteEntity (missile)
		end

	end
end

function MissileProcessor:spawnMissiles (dt)
	-- spawn new missiles
	local player = self.em:findEntitiesWithTag ({"player"})[1]
	local transform = self.em:getData (player, TransformData:getClass ())
	local velocity = self.em:getData (player, VelocityData:getClass ())

	while 0 < self.missilesToBeFired do
		local missile = self.em:createEntity ({"missile"})
		self.em:addData (missile, TransformData (transform.x, transform.y))
		self.em:addData (
			missile,
			AnimationData (
				"gfx/missile",
				1,
				0,
				{x = -0.5, y = -0.5},
				0,
				1,
				{r = 255, g = 40, b = 0, a = 255}
			)
		)
		--local vx = velocity.x
		local vx = 0
			+ math.sin (transform.rotation) * self.missileSpeed
		--local vy = velocity.y
		local vy = 0
			+ (-math.cos (transform.rotation) * self.missileSpeed)
		self.em:addData (missile, VelocityData (vx, vy))

		self.missilesToBeFired = self.missilesToBeFired - 1
	end
end

function MissileProcessor:handle (event)
	local reaction = self.reactions[event:getClass()]
	if reaction then
		reaction ()
	end
end
