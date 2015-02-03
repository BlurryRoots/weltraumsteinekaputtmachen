require ("lib.lclass.init")

class "MouseButtonUpEvent"

function MouseButtonUpEvent:MouseButtonUpEvent (x, y, button)
	self.position = {
		x = x,
		y = y
	}
	self.button = button
end

function MouseButtonUpEvent:__tostring ()
	return self.button .. "@{" .. self.position.x .. ":" .. self.position.y .. "}"
end
