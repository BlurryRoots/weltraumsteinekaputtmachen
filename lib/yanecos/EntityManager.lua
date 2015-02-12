require ("lib.lclass")

class "EntityManager"

function EntityManager:EntityManager ()
	-- last assigned id
	self.idCounter = 0
	-- tags -> list of ids
	self.tags = {}
	-- id -> list of tags
	self.tagMap = {}
	-- id -> list of assigned data
	self.dataMap = {}
	-- datatypename -> list of entities holding this type of data
	self.typeMap = {}
end

function EntityManager:nextId ()
	self.idCounter = self.idCounter + 1

	return self.idCounter
end

function EntityManager:countEntities ()
	local count = 0

	for _, _ in pairs (self.dataMap) do
		count = count + 1
	end

	return count
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

function EntityManager:deleteEntity (eid)
	if not self.dataMap[eid] then
		error ("There is no entity with id " .. eid)
	end

	for _, data in pairs (self.dataMap[eid]) do
		self.typeMap[data:getClass ()][eid] = nil
	end
	self.dataMap[eid] = nil

	for _, tag in pairs (self.tagMap[eid]) do
		self.tags[tag][eid] = nil
	end
	self.tagMap[eid] = nil
end

function EntityManager:addTag (eid, tag)
	if not self.tags[tag] then
		self.tags[tag] = {}
	end
	self.tags[tag][eid] = eid

	if not self.tagMap[eid] then
		self.tagMap[eid] = {}
	end
	table.insert (self.tagMap[eid], tag)

	return tag, eid
end

function EntityManager:removeTag (eid, tag)
	for _, tag in pairs (self.tagMap[eid]) do
		self.tags[tag][eid] = nil
	end
	self.tagMap[eid] = nil

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
	self.typeMap[typename][eid] = eid

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

function EntityManager:hasData (eid, typename)
	if not self.dataMap[eid] then
		error ("There is no entity with id " .. eid)
	end

	local has = false
	if self.typeMap[typename] then
		return true == self.typeMap[typename][eid]
	end

	return has
end

function EntityManager:getData (eid, typename)
	local data = self.dataMap[eid][typename]
	if not data then
		error ("Entity " .. eid .. " doesnt hold data of type " .. typename)
	end

	return data, eid
end

function EntityManager:findEntitiesWithData (datalist)
	local entities = {}

	-- treat every entity as possible match
	for eid, _ in pairs (self.dataMap) do
		local hasAll = true

		for _, typename in pairs (datalist) do
			hasAll = hasAll
				and self.typeMap[typename]
				and self.typeMap[typename][eid]

			if not hasAll then
				break
			end
		end

		if hasAll then
			entities[eid] = eid
		end
	end

	return entities
end

function EntityManager:findEntitiesWithTag (taglist)
	local entities = {}

	-- treat every entity as possible match
	for eid, _ in pairs (self.dataMap) do
		local hasAll = true

		for _, tag in pairs (taglist) do
			hasAll = hasAll
				and self.tags[tag]
				and self.tags[tag][eid]

			if not hasAll then
				break
			end
		end

		if hasAll then
			entities[eid] = eid
		end
	end

	return entities
end
