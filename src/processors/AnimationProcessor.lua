require ("lib.lclass")
require ("lib.yanecos.Processor")

class "AnimationProcessor" ("Processor")

function AnimationProcessor:AnimationProcessor (entityManager, assets)
	self.entityManager = entityManager
	self.assets = assets
end

function AnimationProcessor:onUpdate (dt)
	-- do nothing for now; maybe process event here?
end

function AnimationProcessor:onRender ()

end

function AnimationProcessor:handle (event)

end
