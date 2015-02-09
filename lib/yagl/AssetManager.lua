require ("lib.lclass")

class "AssetManager"

function AssetManager:AssetManager ()
	self.assets = {}
end

function AssetManager:push (key, value)
	self.assets[key] = value
end

function AssetManager:get (key)
	return self.assets[key]
end

function AssetManager:has (key)
	return not self.assets[key]
end
