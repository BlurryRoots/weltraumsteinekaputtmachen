require ("lib.lclass.init")

class "KeyboardKeyDownEvent"

function KeyboardKeyDownEvent:KeyboardKeyDownEvent (key)
	self.key = key
end

function KeyboardKeyDownEvent:Key()
  return self.key
end
