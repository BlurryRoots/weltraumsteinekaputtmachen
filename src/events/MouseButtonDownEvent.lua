require ("lib.lclass.init")

class "MouseButtonDownEvent"

MouseButtonDownEvent.typeName = "MouseButtonDownEvent"

function MouseButtonDownEvent:MouseButtonDownEvent (x, y, button)
	self.position = {
		x = x,
		y = y
	}
	self.button = button
end
