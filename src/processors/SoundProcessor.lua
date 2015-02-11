require ("lib.lclass")
require ("lib.yanecos.Processor")
local lume = require ("lib.lume")

class "SoundProcessor" ("Processor")

function SoundProcessor:SoundProcessor (assets)
	self.assets = assets
	self.commands = {
		play = {},
		pause = {},
		resume = {},
		stop = {}
	}
	self.reactions = {
		PlaySoundEvent = function (event)
			table.insert (self.commands.play, {
				key = event.key,
				volume = event.volume,
				loop = event.loop
			})
		end,
		PauseSoundEvent = function (event)
			table.insert (self.commands.pause, {
				key = event.key
			})
		end,
		ResumeSoundEvent = function (event)
			table.insert (self.commands.resume, {
				key = event.key
			})
		end,
		StopSoundEvent = function (event)
			table.insert (self.commands.stop, {
				key = event.key
			})
		end
	}
end

function SoundProcessor:onUpdate (dt)
	lume.each (self.commands.stop, function (cmd)
		local sound = self.assets:get (cmd.key)
		sound:stop ()
	end)
	lume.each (self.commands.pause, function (cmd)
		local sound = self.assets:get (cmd.key)
		sound:pause ()
	end)
	lume.each (self.commands.resume, function (cmd)
		local sound = self.assets:get (cmd.key)
		sound:resume ()
	end)
	lume.each (self.commands.play, function (cmd)
		local sound = self.assets:get (cmd.key)
		sound:setVolume (cmd.volume)
		sound:setLooping (cmd.loop)
		sound:play ()
	end)
end

function SoundProcessor:handle (event)
	local reaction = self.reactions[event:getClass ()]
	if reaction then
		reaction (event)
	end
end
