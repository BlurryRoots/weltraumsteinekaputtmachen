require ("lib.lclass")
require ("lib.yanecos.Data")

class "AnimationData" ("Data")

function AnimationData:AnimationData (key, frames, duration, offset, rotation, scale)
	-- key to look up resource in asset manager
	self.key = key or error ("No asset name specified!")
	-- no frames means a single image
	self.frames = frames or 1
	-- if no duration is given assume a single image and set it to zero
	self.duration = duration or 0
	-- offset from a transfom in the game world
	self.offset = offset
	-- rotation relative to the transform in the world
	self.rotation = rotation
	-- scale relative the transform in the world
	self.scale = scale
	-- to build up a composite structure (tree)
	self.children = {}
end

function AnimationData:addChild (animation)
	table.insert (self.children, animation)
end
