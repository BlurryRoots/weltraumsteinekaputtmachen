require ("lib.lclass.init")

class "KeyboardKeyDownEvent"

KeyboardKeyDownEvent.typeName = "KeyboardKeyDownEvent"

function KeyboardKeyDownEvent:KeyboardKeyDownEvent (key)
	self.key = key
end
