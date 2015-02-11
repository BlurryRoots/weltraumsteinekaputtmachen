require ("lib.lclass")
require ("lib.yanecos.Data")

class "AnimationData" ("Data")

function AnimationData:AnimationData (assetName, duration)
	self.assetName = assetName or error ("No asset name specified!")
	self.duration = duration or error ("You have to specify a duration!")
end

function AnimationData:assetName (assetName)
	if not assetName then
		return self.assetName
	end

	self.assetName = assetName
end

function AnimationData:duration (duration)
	if not duration then
		return self.duration
	end

	self.duration = duration
end
