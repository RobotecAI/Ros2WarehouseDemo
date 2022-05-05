local ros2cmdvel = {
    Properties = {}
}

function ros2cmdvel:OnActivate()
	self._radToDeg = 57.2957795
	self._gravity = -9.81
	self._busReady = false

    self._rotate = Vector3(0,0,0)
    self._linear = Vector3(0,0,0)
    
    self.tickNotificationBus = TickBus.Connect(self);
    self.twistNotificationBus = TwistNotificationBus.Connect(self);
end

function ros2cmdvel:CmdVelReceived(linear, angular)
	self._busReady = true
	self._linear = linear
	self._rotate = angular
	--Debug.Log("CMD_VEL: linear:" .. tostring(linear) .. " angular:" .. tostring(angular))
end

function ros2cmdvel:OnTick(deltaTime, currentTime)
	if not self._busReady then
		return
	end

	RigidBodyRequestBus.Event.SetAngularVelocity(self.entityId, self._rotate*self._radToDeg*deltaTime)
	
	-- World to local linear velocity
	local worldTM = TransformBus.Event.GetWorldTM(self.entityId)
	local plocal =  Transform.TransformVector(worldTM, self._linear)
	
	RigidBodyRequestBus.Event.ApplyLinearImpulse(self.entityId, Vector3(0,0,self._gravity))
	RigidBodyRequestBus.Event.SetLinearVelocity(self.entityId, plocal)
end

function ros2cmdvel:OnDeactivate()
    self.tickNotificationBus:Disconnect()
    self.twistNotificationBus:Disconnect()
end

return ros2cmdvel
