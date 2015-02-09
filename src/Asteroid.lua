require ("lib.lclass")

class "Asteroid"

function Asteroid:Asteroid ()
	self.gfx = {
		asteroid = love.graphics.newImage ("gfx/better_klumpen.png")
	}
	self.r = 255
	self.g = 255
	self.b = 255
	self.x = 500
	self.y = 400
	self.rot = {
		w = self.gfx.asteroid:getWidth () / 2,
		h = self.gfx.asteroid:getHeight () / 2,
		v = 0
	}
	self.scale = 2

	self.rotationSpeed = 2
	self.velocity = 200

	self.MAX_ROTATION = 2 * math.pi

	self.direction = 2

	self.momentum = setmetatable ({x = 0, y = 0}, {
		__tostring = function (self)
			return "{" .. self.x .. "," .. self.y .. "}"
		end
	})

	self.momentum.x = math.sin(self.direction) * self.velocity
	self.momentum.y = -math.cos(self.direction) * self.velocity

	self.isRotating = 1

end

function Asteroid:onUpdate (dt)
	self.rot.v = self.rot.v
		+ (self.isRotating * self.rotationSpeed * dt)
	self.rot.v = self.rot.v % self.MAX_ROTATION

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

function Asteroid:onRender ()
	love.graphics.setColor (self.r, self.g, self.b, 255)
	love.graphics.push ()
		local rotx = self.x + self.rot.w
		local roty = self.y + self.rot.h
		-- rotate around the center of the asteroid (position)
		love.graphics.translate (rotx, roty)
		love.graphics.rotate (self.rot.v)
		love.graphics.translate (-rotx, -roty)
		love.graphics.draw (
			self.gfx.asteroid,
			self.x, self.y
		)
	love.graphics.pop()
	love.graphics.setColor (255, 255, 255, 255)

	local py = 42
	local pyoff = 16
--	love.graphics.print ("rot.v: " .. self.rot.v, 42, py + 0 * pyoff)
--	love.graphics.print ("acc: " .. self.acceleration, 42, py + 1 * pyoff)
--	love.graphics.print ("mom: " .. tostring (self.momentum), 42, py + 2 * pyoff)
end

function Asteroid:handle (event)
	--
end
