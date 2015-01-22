require ("lib.lclass.init")

class "KeyboardKeyUpEvent"

KeyboardKeyUpEvent.typeName = "KeyboardKeyUpEvent"

function KeyboardKeyUpEvent:KeyboardKeyUpEvent (key)
	self.key = key
end
