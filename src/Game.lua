require ("src.events.FocusGainedEvent")
require ("src.events.FocusLostEvent")
require ("src.events.KeyboardKeyDownEvent")
require ("src.events.KeyboardKeyUpEvent")
require ("src.events.MouseButtonDownEvent")
require ("src.events.MouseButtonUpEvent")
require ("src.events.ResizeEvent")

require ("src.EventManager")

require ("lib.lclass.init")

class "Game"

function Game:Game ()
	--
	self.eventManager = EventManager ()

	self.eventManager:subscribe ("FocusGainedEvent", self)
	self.eventManager:subscribe ("FocusLostEvent", self)
	self.eventManager:subscribe ("KeyboardKeyDownEvent", self)
	self.eventManager:subscribe ("KeyboardKeyUpEvent", self)
	self.eventManager:subscribe ("MouseButtonDownEvent", self)
	self.eventManager:subscribe ("MouseButtonUpEvent", self)
	self.eventManager:subscribe ("ResizeEvent", self)

	self.message = "keksnase!"
end

function Game:raise (event)
	--
	print ("trying to raise event " .. event.typeName)
	self.eventManager:push (event)
end

function Game:handle (event)
	--
	if "MouseButtonDownEvent" == event.typeName then
		self.message = event.button
	end
	if "MouseButtonUpEvent" == event.typeName then
		self.message = "keksnase!"
	end
end

function Game:onUpdate (dt)
	--
	self.eventManager:update (dt)
end

function Game:onRender ()
	love.graphics.print (self.message, 42, 42)
end

function Game:onExit ()
end
