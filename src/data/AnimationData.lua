require ("lib.lclass")
require ("lib.yanecos.Data")

class "AnimationData" ("Data")

function AnimationData:AnimationData (key, frames, duration, offset, rotation, scale, color)
	-- key to look up resource in asset manager
	self.key = key or error ("No asset name specified!")
	-- no frames means a single image
	self.frames = frames or 1
	-- if no duration is given assume a single image and set it to zero
	self.duration = duration or 0
	-- offset from a transfom in the game world
	self.offset = offset or {x = 0, y = 0}
	-- rotation relative to the transform in the world
	self.rotation = rotation or 0
	-- scale relative the transform in the world
	self.scale = scale or 1
	-- to build up a composite structure (tree)
	self.children = {}
	-- should it be rendered?
	self.visible = true
	-- color to render the animation in
	self.color = color
end

function AnimationData:addChild (animation)
	table.insert (self.children, animation)

	return animation
end
