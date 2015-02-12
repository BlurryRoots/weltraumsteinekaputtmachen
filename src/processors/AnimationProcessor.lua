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
	local entities = self.entityManager:findEntitiesWithData ({
		TransformData:getClass (),
		AnimationData:getClass ()
	})

	for _, eid in pairs (entities) do
		local transform =
			self.entityManager:getData (eid, TransformData:getClass ())
		local animation =
			self.entityManager:getData (eid, AnimationData:getClass ())

		love.graphics.push ()
			-- rotate around the center of the ship (position)
			love.graphics.translate (transform.x, transform.y)
				love.graphics.scale (transform.scale)
				love.graphics.rotate (transform.rotation)
				self:renderAnimationTree (animation, transform)
			love.graphics.translate (-transform.x, -transform.y)
		love.graphics.pop()
	end
end

function AnimationProcessor:renderAnimationTree (animation)
	local image = self.assets:get (animation.key)
	local offset = {
		x = animation.offset.x * image:getWidth (),
		y = animation.offset.y * image:getHeight ()
	}

	love.graphics.push ()
		-- rotate around the center of the ship (position)
		love.graphics.translate (offset.x, offset.y)
			love.graphics.scale (animation.scale)
			love.graphics.rotate (animation.rotation)

			local r, g, b, a = love.graphics.getColor ()
			if animation.color then
				love.graphics.setColor (
					animation.color.r,
					animation.color.g,
					animation.color.b,
					animation.color.a
				)
			end
			love.graphics.draw (image, 0, 0)
			love.graphics.setColor (r, g, b, a)

			for _, child in pairs (animation.children) do
				if child.visible then
					self:renderAnimationTree (child)
				end
			end
		love.graphics.translate (-offset.x, -offset.y)
	love.graphics.pop()
end

function AnimationProcessor:handle (event)

end
