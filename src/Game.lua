require("src.events.FocusGainedEvent")
require("src.events.FocusLostEvent")
require("src.events.KeyboardKeyDownEvent")
require("src.events.KeyboardKeyUpEvent")
require("src.events.MouseButtonDownEvent")
require("src.events.MouseButtonUpEvent")
require("src.events.ResizeEvent")

require("lib.lclass.init")

class "Game"

function Game:Game()
end

function Game:raise(event)
end

function Game:onUpdate(dt)
	--
end

function Game:onRender()
	love.graphics.print("keksnase!", 42, 42)
end

function Game:onExit()
end
