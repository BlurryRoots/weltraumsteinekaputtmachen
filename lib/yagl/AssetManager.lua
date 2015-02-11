require ("lib.lclass")

class "AssetManager"

function AssetManager:AssetManager ()
	self.assets = {}
end

function AssetManager:loadSound (path, key)
	self:loadVia (love.audio.newSource, path, key)
end

function AssetManager:loadImage (path, key)
	self:loadVia (love.graphics.newImage, path, key)
end

function AssetManager:loadVia (loader, path, key)
	local resource = loader (path)
	if not resource then
		error ("Could not load resource from " .. path)
	end

	self:push (key, resource)
end

function AssetManager:push (key, value)
	self.assets[key] = value
end

function AssetManager:get (key)
	if not self:has (key) then
		error ("Could not find resource called " .. key)
	end

	return self.assets[key]
end

function AssetManager:has (key)
	return not (not self.assets[key])
end
