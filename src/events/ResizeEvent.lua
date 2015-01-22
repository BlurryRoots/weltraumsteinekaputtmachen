require ("lib.lclass.init")

class "ResizeEvent"

ResizeEvent.typeName = "ResizeEvent"

function ResizeEvent:ResizeEvent (w, h)
	self.width = w
	self.height = h
end
