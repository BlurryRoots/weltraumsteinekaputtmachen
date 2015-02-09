require ("lib.lclass")

class "Ship"

function Ship:Ship ()
	self.gfx = {
		ship = love.graphics.newImage ("gfx/schiff.png"),
		jetflame = love.graphics.newImage ("gfx/flamme.png")
	}
	self.r = 255
	self.g = 255
	self.b = 255
	self.x = 200
	self.y = 200
	self.rot = {
		w = self.gfx.ship:getWidth () / 2,
		h = self.gfx.ship:getHeight () / 2,
		v = 0
	}
	self.scale = 1

	self.jetflame = {
		x = 0,
		y = 0
	}

	self.rotationSpeed = 10
	self.accelerationSpeed = 32

	self.MAX_ACCELERATION = 32
	self.acceleration = 0
	self.MAX_ROTATION = 2 * math.pi
	self.rotation = 0

	self.momentum = setmetatable ({x = 0, y = 0}, {
		__tostring = function (self)
			return "{" .. self.x .. "," .. self.y .. "}"
		end
	})

	self.isAccelerating = 0
	self.isRotating = 0

	self.reactions = {
		KeyboardKeyDownEvent = function (event)
			local switch = {
				w = function ()
					self.isAccelerating = self.isAccelerating + 1
				end,
				a = function ()
					self.isRotating = self.isRotating - 1
				end,
				d = function ()
					self.isRotating = self.isRotating + 1
				end
			}

			local case = switch[event:Key ()]
			if case then
				case ()
			end
		end,

		KeyboardKeyUpEvent = function (event)
			local switch = {
				w = function ()
					self.isAccelerating = self.isAccelerating - 1
				end,
				a = function ()
					self.isRotating = self.isRotating + 1
				end,
				d = function ()
					self.isRotating = self.isRotating - 1
				end
			}

			local case = switch[event:Key ()]
			if case then
				case ()
			end
		end
	}
end

function Ship:onUpdate (dt)
	self.rot.v = self.rot.v
		+ (self.isRotating * self.rotationSpeed * dt)
	self.rot.v = self.rot.v % self.MAX_ROTATION

	self.momentum.x = self.momentum.x
		+ (math.sin (self.rot.v) * self.isAccelerating * self.accelerationSpeed)

	self.momentum.y = self.momentum.y
		+ (-math.cos (self.rot.v) * self.isAccelerating * self.accelerationSpeed)

	self.x = self.x + (self.momentum.x * dt)
	self.y = self.y + (self.momentum.y * dt)

	if self.x > love.graphics.getWidth() then
		self.x = 0
	end

	if self.y > love.graphics.getHeight() then
		self.y = 0
	end

	if self.x < 0 then
		self.x = love.graphics.getWidth()
	end

	if self.y < 0 then
		self.y = love.graphics.getHeight()
	end

end

function Ship:onRender ()
	love.graphics.setColor (self.r, self.g, self.b, 255)
	love.graphics.push ()
		local rotx = self.x + self.rot.w
		local roty = self.y + self.rot.h
		-- rotate around the center of the ship (position)
		love.graphics.translate (rotx, roty)
		love.graphics.rotate (self.rot.v)
		love.graphics.translate (-rotx, -roty)
		love.graphics.draw (
			self.gfx.ship,
			self.x, self.y
		)
		if not (self.isAccelerating == 0) then
			love.graphics.draw (
				self.gfx.jetflame,
				self.x, self.y + self.rot.h * 2
			)
		end
	love.graphics.pop()
	love.graphics.setColor (255, 255, 255, 255)

	local py = 42
	local pyoff = 16
	love.graphics.print ("rot.v: " .. self.rot.v, 42, py + 0 * pyoff)
	love.graphics.print ("acc: " .. self.acceleration, 42, py + 1 * pyoff)
	love.graphics.print ("mom: " .. tostring (self.momentum), 42, py + 2 * pyoff)
end

function Ship:handle (event)
	local reaction = self.reactions[event:getClass()]
	if reaction then
		reaction (event)
	end
end
