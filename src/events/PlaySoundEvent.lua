require ("lib.lclass.init")

class "PlaySoundEvent"

function PlaySoundEvent:PlaySoundEvent (key, volume, loop)
	self.key = key
	self.volume = volume
	self.loop = loop
end
