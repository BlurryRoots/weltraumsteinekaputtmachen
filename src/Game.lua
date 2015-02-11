require ("lib.lclass")
require ("lib.yagl.AssetManager")

require ("src.EventManager")

require ("src.processors.SoundProcessor")

require ("src.events.FocusGainedEvent")
require ("src.events.FocusLostEvent")
require ("src.events.KeyboardKeyDownEvent")
require ("src.events.KeyboardKeyUpEvent")
require ("src.events.MouseButtonDownEvent")
require ("src.events.MouseButtonUpEvent")
require ("src.events.ResizeEvent")
require ("src.events.PlaySoundEvent")

require ("src.Ship")

class "Game"

-- Constructs a new game
function Game:Game ()
	self.eventManager = EventManager ()

	self.eventManager:subscribe ("FocusGainedEvent", self)
	self.eventManager:subscribe ("FocusLostEvent", self)
	self.eventManager:subscribe ("KeyboardKeyDownEvent", self)
	self.eventManager:subscribe ("KeyboardKeyUpEvent", self)
	self.eventManager:subscribe ("MouseButtonDownEvent", self)
	self.eventManager:subscribe ("MouseButtonUpEvent", self)
	self.eventManager:subscribe ("ResizeEvent", self)

	self.assets = AssetManager ()

	self.assets:loadImage ("gfx/bg.png", "gfx/bg")
	self.assets:loadSound ("sfx/song_loop1.mp3", "sfx/loop1")

	self.shipoflife = Ship ()
	self.eventManager:subscribe ("KeyboardKeyDownEvent", self.shipoflife)
	self.eventManager:subscribe ("KeyboardKeyUpEvent", self.shipoflife)

	self.soundProcessor = SoundProcessor (self.assets)
	self.eventManager:subscribe ("PlaySoundEvent", self.soundProcessor)

	self.reactions = {
		KeyboardKeyUpEvent = function (event)
			local switch = {
				escape = function ()
					love.event.quit()
				end,
				q = function ()
					love.event.quit()
				end
			}

			local case = switch[event:Key ()]
			if case then
				case ()
			end
		end
	}

	self.eventManager:push (PlaySoundEvent ("sfx/loop1", 0.8, true))
end

-- Raises (queues) a new event
function Game:raise (event)
	self.eventManager:push (event)
end

-- Callback used by EventManager
function Game:handle (event)
	local reaction = self.reactions[event:getClass()]
	if reaction then
		reaction (event)
	end
end

-- Updates game logic
function Game:onUpdate (dt)
	self.soundProcessor:onUpdate (dt)

	self.eventManager:update (dt)
	self.shipoflife:onUpdate (dt)
end

-- Renders stuff onto the screen
function Game:onRender ()
	local bg = self.assets:get ("gfx/bg")

	local width = love.graphics.getWidth ()
	local height = love.graphics.getHeight ()
	local scaleX = width / bg:getWidth ()
	local scaleY = height / bg:getHeight ()

	love.graphics.draw (bg, 0, 0, 0, scaleX, scaleY)

	self.shipoflife:onRender ()
end

-- Gets called when game exits. May be used to do some clean up.
function Game:onExit ()
	--
end

function Game:issueCommand (command)
	table.insert (self.commands, command)
end
