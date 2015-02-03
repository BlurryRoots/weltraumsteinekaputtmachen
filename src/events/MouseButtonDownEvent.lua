require ("lib.lclass.init")

class "MouseButtonDownEvent"

function MouseButtonDownEvent:MouseButtonDownEvent (x, y, button)
	self.position = {
		x = x,
		y = y
	}
	self.button = button
end

function MouseButtonDownEvent:__tostring ()
	return self.button .. "@{" .. self.position.x .. ":" .. self.position.y .. "}"
end

function MouseButtonDownEvent:x ()
	return self.position.x
end
function MouseButtonDownEvent:y ()
	return self.position.y
end