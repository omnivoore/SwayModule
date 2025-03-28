--!strict
local RunService = game:GetService("RunService")

export type SwayModule = {
	_origins: {[Motor6D]: CFrame},
	_connection: RBXScriptConnection?,
	_motors: {[Motor6D]: {time: number, multiplier: vector, speed: number}},
	__index: SwayModule,

	Create: (self: SwayModule, motor: Motor6D, multiplier: vector, speed: number) -> (),
	-- Creates a new "sway" instance
	Release: (self: SwayModule, motor: Motor6D) -> (),
	-- Releases the current motor and stops it from swaying
	Listen: (self: SwayModule) -> (),
	-- Starts swaying all sway instances
	Disconnect: (self: SwayModule) -> (),
	-- Stops swaying all sway instances
}

-- / non modular variables
local random = Random.new()
local sin = math.sin

-- / customizable
local orientationMultplier = 3

-- / module
local module: SwayModule = {} :: SwayModule
module.__index = module
module._origins = {}
module._connection = nil
module._motors = {}

function module:Create(motor, multiplier, speed)
	self._origins[motor] = motor.C0
	self._motors[motor] = {
		time = random:NextNumber(0, 120),
		multiplier = multiplier,
		speed = speed
	}
end

function module:Release(motor)
	self._motors[motor] = nil
end

function module:Listen()
	assert(not self._connection, `There is already a connection.`)

	self._connection = RunService.Heartbeat:Connect(function(dt)
		for motor, data in pairs(self._motors) do
			data.time += dt
			local time, speed = data.time, data.speed
			local tSin, ySin = sin(time * data.speed), sin(time * data.speed / 2)

			local offset = CFrame.new(
				tSin * data.multiplier.x,
				ySin * data.multiplier.y,
				tSin * data.multiplier.z
			) * CFrame.Angles(
				math.rad(tSin * data.multiplier.x * orientationMultplier),
				math.rad(ySin * data.multiplier.y * orientationMultplier),
				math.rad(tSin * data.multiplier.z * orientationMultplier)
			)

			motor.C0 = self._origins[motor] * offset
		end
	end)
end

function module:Disconnect()
	assert(self._connection, `There are no connections.`)

	self._connection:Disconnect()
	self._connection = nil
end

return module
