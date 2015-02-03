require ("lib.lclass")

class "Ship"

function Ship:Ship ()
	self.gfx = love.graphics.newImage ("gfx/schiff.png")
	self.r = 255
	self.g = 255
	self.b = 255
	self.x = 200
	self.y = 200
	self.rot = {
		w = self.gfx:getWidth () / 2,
		h = self.gfx:getHeight () / 2,
		v = 0
	}
	self.scale = 1
end

function Ship:onUpdate (dt)
	--
end

function Ship:onRender ()
	love.graphics.push ()
		love.graphics.setColor (self.r, self.g, self.b, 255)
		love.graphics.push ()
			love.graphics.draw (
				self.gfx,
				self.x, self.y,
				self.rot.v,
				self.scale, self.scale,
				self.rot.w, self.rot.h
			)
		love.graphics.pop ()

		love.graphics.setColor (255, 255, 255, 255)
	love.graphics.pop()
end
