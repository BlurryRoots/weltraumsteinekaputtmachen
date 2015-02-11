require ("lib.lclass")

class "EntityManager"

function EntityManager:EntityManager ()
	-- last assigned id
	self.idCounter = 0
	-- tags -> list of ids
	self.tags = {}
	-- id -> list of assigned data
	self.data = {}
end

function EntityManager:nextId ()
	self.idCounter = self.idCounter + 1

	return self.idCounter
end

function EntityManager:createEntity (tags)
	-- fetch newly created id (no need for reuse lua has bignum (whoohoo :D))
	local eid = self:nextId ()
	-- create empty data list for entity
	self.data[eid] = {}
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
end

function EntityManager:addData (eid, data)
	if self:hasData (eid, data) then
		error ("Entity " .. eid .. " already has data of type " .. data.__type)
	end

	table.insert (self.data[eid], data)
end

function EntityManager:removeData (eid, datatype)
	if not self:hasData (eid, data) then
		error ("Entity " .. eid .. " has no data of type " .. data.__type)
	end
end

function EntityManager:hasData (eid, datatype)
	if not self.data[eid] then
		error ("There is no entity with id " .. eid)
	end

	local has = false
	for _, data in pairs (self.data[eid]) do
		has = data.__type == datatype.__type
		if has then
			break
		end
	end

	return has
end

function EntityManager:getData (eid, datatype)
	if not self.data[eid] then
		error ("There is no entity with id " .. eid)
	end

	return self.data[eid]
end
