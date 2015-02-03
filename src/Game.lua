require ("lib.lclass")

require ("src.EventManager")

require ("src.data.PositionData")

require ("src.events.FocusGainedEvent")
require ("src.events.FocusLostEvent")
require ("src.events.KeyboardKeyDownEvent")
require ("src.events.KeyboardKeyUpEvent")
require ("src.events.MouseButtonDownEvent")
require ("src.events.MouseButtonUpEvent")
require ("src.events.ResizeEvent")

require ("src.Ship")

class "Game"

-- Constructs a new game
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

  self.bg = love.graphics.newImage("gfx/bg.jpg")

	self.log = {}
	self.shipoflife = Ship ()
end

-- Raises (queues) a new event
function Game:raise (event)
	--
	self.eventManager:push (event)
end

-- Callback used by EventManager
function Game:handle (event)
	--
	print ("trying to handle " .. type (event))
	if event:getClass () == "MouseButtonUpEvent" then
		table.insert (self.log, {
			timestamp = tostring (os.date ("%c")),
			ttl = 4,
			tal = 0,
			message = tostring (event)
		})
	end
end

-- Updates game logic
function Game:onUpdate (dt)
	--
	self.eventManager:update (dt)
	self.shipoflife:onUpdate (dt)

	local toberemoved = {}
	for i, v in pairs (self.log) do
		if (v.ttl - v.tal) <= 0 then
			table.insert (toberemoved, i)
		else
			v.tal = v.tal + dt
		end
	end
	for i, v in pairs (toberemoved) do
		table.remove (self.log, v)
	end
end

-- Renders stuff onto the screen
function Game:onRender ()
	--
  local width = love.graphics.getWidth()
  local height = love.graphics.getHeight()
  local scaleX = self.bg:getWidth() / width
  local scaleY = self.bg:getHeight() / height
  
  love.graphics.draw(self.bg, 0, 0, 0, scaleX, scaleY)
	self:renderLog ()
	self.shipoflife:onRender ()
  
end

-- Gets called when game exits. May be used to do some clean up.
function Game:onExit ()
	--
end

function Game:renderLog ()
	--
	local basepos = {x = 42, y = 42}
	for i, v in pairs (self.log) do
		local msg = "[" .. v.timestamp .. "]: " .. v.message
		local y = basepos.y + (i - 1) * 21
		love.graphics.print (msg, basepos.x, y)
	end
end
