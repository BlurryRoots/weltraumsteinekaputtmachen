require ("lib.lclass.init")

class "KeyboardKeyUpEvent"

function KeyboardKeyUpEvent:KeyboardKeyUpEvent (key)
	self.key = key
end

function KeyboardKeyUpEvent:Key ()
  return self.key
end
