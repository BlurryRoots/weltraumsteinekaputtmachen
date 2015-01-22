require ("lib.lclass.init")

class "MouseButtonUpEvent"

MouseButtonUpEvent.typeName = "MouseButtonUpEvent"

function MouseButtonUpEvent:MouseButtonUpEvent (x, y, button)
	self.position = {
		x = x,
		y = y
	}
	self.button = button
end
