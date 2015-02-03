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
  self.rotationSpeed = 10
  self.accelerationSpeed = 33

  self.acceleration = 0
  self.rotation = 0

  self.momentum = {
    x = 0,
    y = 0,
    __tostring = function(self)
      return "{" .. self.x .. "," .. self.y .. "}"
    end
  }
  self.isAccelerating = 0
  self.isRotating = 0

  self.reactions = {
    KeyboardKeyDownEvent = function(event) 
      if event:Key() == "w" then
        self.isAccelerating = self.isAccelerating + 1
      end

      if event:Key() == "s" then
        self.isAccelerating = self.isAccelerating - 1
      end

      if event:Key() == "a" then
        self.isRotating = self.isRotating - 1
      end

      if event:Key() == "d" then
        self.isRotating = self.isRotating + 1
      end
    end,

    KeyboardKeyUpEvent = function(event)
      if event:Key() == "w" then
        self.isAccelerating = self.isAccelerating - 1
      end

      if event:Key() == "s" then
        self.isAccelerating = self.isAccelerating + 1
      end

      if event:Key() == "a" then
        self.isRotating = self.isRotating + 1
      end

      if event:Key() == "d" then
        self.isRotating = self.isRotating - 1
      end
    end
  }
end

function Ship:onUpdate (dt)
  self.rot.v = self.rot.v + 
    (self.isRotating * self.rotationSpeed * dt)

  self.acceleration = self.acceleration + 
    (self.isAccelerating * self.accelerationSpeed * dt)

  self.momentum.x = (math.cos(self.rot.v) * 
    self.momentum.x - math.sin(self.rot.v) * self.momentum.y) *
    self.acceleration

  self.momentum.y = (math.sin(self.rot.v) * 
    self.momentum.x + math.cos(self.rot.v) * self.momentum.y) *
    self.acceleration

  self.x = self.x + (self.momentum.x * dt)
  self.y = self.y + (self.momentum.y * dt)
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
  love.graphics.print (tostring (self.acceleration), 42, 42)
  love.graphics.print (tostring (self.momentum.x), 242, 42)
  love.graphics.print (tostring (self.momentum.y), 442, 42)
end

function Ship:handle (event)
  self.reactions[event:getClass()](event)
end
