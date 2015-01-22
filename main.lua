require ("src.Game")

local gameInstance = nil

function love.load ()
	gameInstance = Game ()
end

function love.quit ()
	gameInstance:onExit ()
end

function love.focus (f)
	if f then
		gameInstance:raise (FocusLostEvent ())
	else
		gameInstance:raise (FocusGainedEvent ())
	end
end

function love.resize (w, h)
	gameInstance:raise (ResizeEvent (w, h))
end

function love.update (dt)
	gameInstance:onUpdate (dt)
end

function love.draw ()
	gameInstance:onRender ()
end

function love.mousepressed (x, y, button)
	gameInstance:raise (MouseButtonDownEvent (x, y, button))
end

function love.mousereleased (x, y, button)
	gameInstance:raise (MouseButtonUpEvent (x, y, button))
end

function love.keypressed (key)
	gameInstance:raise (KeyboardKeyDownEvent (key))
end

function love.keyreleased (key)
	gameInstance:raise (KeyboardKeyUpEvent (key))
end
