require ("lib.lclass")
require ("lib.yanecos.Processor")

require ("src.events.FireMissileEvent")

class "PlayerInputProcessor" ("Processor")

function PlayerInputProcessor:PlayerInputProcessor (entityManager, eventManager)
	self.entityManager = entityManager
	self.eventManager = eventManager
	self.accelerateShip = 0
	self.rotateShip = 0

	self.rotationSpeed = 10
	self.MAX_ROTATION = 2 * math.pi
	self.accelerationSpeed = 16

	self.reactions = {
		KeyboardKeyUpEvent =  {
			escape = function ()
				love.event.quit()
			end,
			q = function ()
				love.event.quit()
			end,
			w = function ()
				self.accelerateShip = self.accelerateShip - 1
			end,
			a = function ()
				self.rotateShip = self.rotateShip + 1
			end,
			d = function ()
				self.rotateShip = self.rotateShip - 1
			end,
			j = function ()
				self.eventManager:push (FireMissileEvent ())
			end
		},

		KeyboardKeyDownEvent = {
			w = function ()
				self.accelerateShip = self.accelerateShip + 1
			end,
			a = function ()
				self.rotateShip = self.rotateShip - 1
			end,
			d = function ()
				self.rotateShip = self.rotateShip + 1
			end
		}
	}
end

function PlayerInputProcessor:onUpdate (dt)
	local player = self.entityManager:findEntitiesWithTag ({"player"})[1]

	-- do stuff with players transform
	local transform =
		self.entityManager:getData (player, TransformData:getClass ())
	transform.rotation = transform.rotation
		+ (self.rotateShip * self.rotationSpeed * dt)
	transform.rotation = transform.rotation % self.MAX_ROTATION

	if transform.x > love.graphics.getWidth () then
		transform.x = 0
	end
	if transform.y > love.graphics.getHeight () then
		transform.y = 0
	end
	if transform.x < 0 then
		transform.x = love.graphics.getWidth ()
	end
	if transform.y < 0 then
		transform.y = love.graphics.getHeight ()
	end

	-- calculate new velocity
	local velocity =
		self.entityManager:getData (player, VelocityData:getClass ())
	velocity.x = velocity.x
		+ (math.sin (transform.rotation) * self.accelerateShip
			* self.accelerationSpeed)
	velocity.y = velocity.y
		+ (-math.cos (transform.rotation) * self.accelerateShip
			* self.accelerationSpeed)

	-- show thruster flame if ship is accelerating
	local animation =
		self.entityManager:getData (player, AnimationData:getClass ())
	animation.children[1].visible = not (0 == self.accelerateShip)
end

function PlayerInputProcessor:handle (event)
	local keymap = self.reactions[event:getClass()]
	if keymap and keymap[event:Key ()] then
		keymap[event:Key ()] ()
	end
end
