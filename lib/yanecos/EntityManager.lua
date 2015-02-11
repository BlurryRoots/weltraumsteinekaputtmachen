require ("lib.lclass")

class "EntityManager"

function EntityManager:EntityManager ()
	-- last assigned id
	self.idCounter = 0
	-- tags -> list of ids
	self.tags = {}
	-- id -> list of assigned data
	self.dataMap = {}
	-- datatypename -> list of entities holding this type of data
	self.typeMap = {}
end

function EntityManager:nextId ()
	self.idCounter = self.idCounter + 1

	return self.idCounter
end

function EntityManager:createEntity (tags)
	-- fetch newly created id (no need for reuse lua has bignum (whoohoo :D))
	local eid = self:nextId ()
	-- create empty data list for entity
	self.dataMap[eid] = {}
	-- add tags if any
	if tags then
		for _, tag in pairs (tags) do
			self:addTag (eid, tag)
		end
	end

	return eid
end

function EntityManager:addTag (eid, tag)
	if not self.tags[tag] then
		self.tags[tag] = {}
	end

	table.insert (self.tags[tag], eid)

	return tag, eid
end

function EntityManager:addData (eid, data)
	local typename = data:getClass ()

	if self:hasData (eid, typename) then
		error ("Entity " .. eid .. " already has data of type " .. typename)
	end

	-- store data in data map
	self.dataMap[eid][typename] = data
	-- mark id in type map
	if not self.typeMap[typename] then
		self.typeMap[typename] = {}
	end
	self.typeMap[typename][eid] = true

	return data, eid
end

function EntityManager:removeData (eid, typename)
	if not self:hasData (eid, typename) then
		error ("Entity " .. eid .. " has no data of type " .. typename)
	end

	self.dataMap[eid][typename] = nil
	self.typeMap[typename][eid] = nil

	return typename, eid
end

local inspect = require ("lib.inspect")
function EntityManager:hasData (eid, typename)
	if not self.dataMap[eid] then
		error ("There is no entity with id " .. eid)
	end
	print ("Checking if " .. eid .. " has " .. typename)
	local has = false
	if self.typeMap[typename] then
		return true == self.typeMap[typename][eid]
	end
	print ("Result: " .. tostring (has))
	print ("TypeMap: " .. inspect (self.typeMap))
	return has
end

function EntityManager:getData (eid, typename)
	local data = self.dataMap[eid][typename]
	if not data then
		error ("Entity " .. eid .. " doesnt hold data of type " .. typename)
	end

	return data, eid
end

function EntityManager:findEntitiesByData (datalist)

end

function EntityManager:findEntitiesByTag (taglist)
end
