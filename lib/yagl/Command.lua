require ("lib.lclass")

class "Command"

function Command:Command (name)
	self.name = name or ("NONAME" .. os.time ())
end

function Command:execute (dt)
	-- do nothing
end
