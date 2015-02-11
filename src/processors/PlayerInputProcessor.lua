require ("lib.lclass")
require ("lib.yanecos.Processor")

class "PlayerInputProcessor" ("Processor")

function PlayerInputProcessor:PlayerInputProcessor (entityManager)
	self.entityManager = entityManager
	self.accelerateShip = 0
	self.rotateShip = 0

	self.rotationSpeed = 10
	self.MAX_ROTATION = 2 * math.pi
	self.accelerationSpeed = 32

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
	local player = self.entityManager:findEntitiesWithTag ({"player"})

	local transform =
		self.entityManager:getData (player, TransformData:getClass ())
	transform.rotation = transform.rotation
		+ (self.rotateShip * self.rotationSpeed * dt)
	transform.rotation = transform.rotation % self.MAX_ROTATION

	local velocity =
		self.entityManager:getData (player, VelocityData:getClass ())
	velocity.x = velocity.x
		+ (math.sin (transform.rotation) * self.accelerateShip
			* self.accelerationSpeed)
	velocity.y = velocity.y
		+ (-math.cos (transform.rotation) * self.accelerateShip
			* self.accelerationSpeed)
end

function PlayerInputProcessor:handle (event)
	local keymap = self.reactions[event:getClass()]
	if keymap and keymap[event:Key ()] then
		keymap[event:Key ()] ()
	end
end
