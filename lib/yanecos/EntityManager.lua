require ("lib.lclass")

class "EntityManager"

function EntityManager:EntityManager (datebase)
	if not database then
		error ("EntityManager needs a database!")
	end
	self.database = database
end

function EntityManager:CreateEntity ()
	--
end

function EntityManager:AddData (eid, data)
end

function EntityManager:RemoveData (eid, datatype)
end

function EntityManager:GetData (eid, datatype)
end
