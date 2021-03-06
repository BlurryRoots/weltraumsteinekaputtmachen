require ("lib.lclass")
require ("lib.yagl.AssetManager")
require ("lib.yanecos.EntityManager")

require ("src.EventManager")

require ("src.data.AnimationData")
require ("src.data.MassData")
require ("src.data.ThrusterData")
require ("src.data.TransformData")
require ("src.data.VelocityData")

require ("src.processors.SoundProcessor")
require ("src.processors.AnimationProcessor")
require ("src.processors.PlayerInputProcessor")
require ("src.processors.MovementProcessor")
require ("src.processors.MissileProcessor")

require ("src.events.FocusGainedEvent")
require ("src.events.FocusLostEvent")
require ("src.events.KeyboardKeyDownEvent")
require ("src.events.KeyboardKeyUpEvent")
require ("src.events.MouseButtonDownEvent")
require ("src.events.MouseButtonUpEvent")
require ("src.events.ResizeEvent")
require ("src.events.PlaySoundEvent")

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
	self.assets:loadImage ("gfx/flamme.png", "gfx/flame")
	self.assets:loadImage ("gfx/schiff.png", "gfx/ship")
	self.assets:loadImage ("gfx/missile.png", "gfx/missile")
	self.assets:loadSound ("sfx/song_loop1.mp3", "sfx/loop1")

	self.entityManager = EntityManager ()

	local ship = self.entityManager:createEntity ({"player"})
	self.entityManager
		:addData (ship, TransformData (0, 0))
	self.entityManager
		:addData (ship, MassData (1337))
	self.entityManager
		:addData (ship, ThrusterData (314))
	self.entityManager
		:addData (ship, VelocityData ())
	self.entityManager
		-- center ship animation on transform position
		:addData (ship, AnimationData ("gfx/ship", 1, 0, {x = -0.5, y = -0.5}))
		-- offset flame animation so it sits behind thrusters
		:addChild (AnimationData ("gfx/flame", 1, 0, {x = 0.0, y = 1.0}))
		-- initialize the flames to be invisible
		.visible = false

	self.soundProcessor = SoundProcessor (self.assets)
	self.eventManager:subscribe ("PlaySoundEvent", self.soundProcessor)

	self.animationProcessor =
		AnimationProcessor (self.entityManager, self.assets)

	self.playerInputProcessor =
		PlayerInputProcessor (self.entityManager, self.eventManager)
	self.eventManager
		:subscribe ("KeyboardKeyDownEvent", self.playerInputProcessor)
	self.eventManager
		:subscribe ("KeyboardKeyUpEvent", self.playerInputProcessor)

	self.movementProcessor = MovementProcessor (self.entityManager)

	self.missileProcessor =
		MissileProcessor (self.entityManager, self.eventManager)
	self.eventManager
		:subscribe ("FireMissileEvent", self.missileProcessor)

	self.eventManager:push (PlaySoundEvent ("sfx/loop1", 0.8, true))
end

-- Raises (queues) a new event
function Game:raise (event)
	self.eventManager:push (event)
end

-- Callback used by EventManager
function Game:handle (event)
	--
end

-- Updates game logic
function Game:onUpdate (dt)
	--print ("Number of entities: " .. self.entityManager:countEntities ())
	self.eventManager:update (dt)

	self.playerInputProcessor:onUpdate (dt)
	self.missileProcessor:onUpdate (dt)
	self.movementProcessor:onUpdate (dt)
	self.soundProcessor:onUpdate (dt)
	self.animationProcessor:onUpdate (dt)
end

-- Renders stuff onto the screen
function Game:onRender ()
	local bg = self.assets:get ("gfx/bg")

	local width = love.graphics.getWidth ()
	local height = love.graphics.getHeight ()
	local scaleX = width / bg:getWidth ()
	local scaleY = height / bg:getHeight ()

	love.graphics.draw (bg, 0, 0, 0, scaleX, scaleY)

	self.animationProcessor:onRender ()
end

-- Gets called when game exits. May be used to do some clean up.
function Game:onExit ()
	--
end

function Game:issueCommand (command)
	table.insert (self.commands, command)
end
