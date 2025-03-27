# SwayModule
`SwayModule` is a lightweight module for creating smooth procedural swaying movements or adding subtle motion to Motor6D instances. `SwayModule` uses typechecking to improve the workflow of developers.

## Installation
1. Import the `SwayModule` module.
2. Require the module when needed.

## API Reference
### `SwayModule:Create(motor: Motor6D, multiplier: Vector3, speed: number)`
Creates a new sway instance on the given `Motor6D` instance.
- `motor` - The target `Motor6D` instance to apply swaying.
- `multiplier` - The distance of swaying per each vector axis.
- `speed` - The speed / tick rate of sways.
### `SwayModule:Release(motor: Motor6D)`
Stops and removes the sway effect from the specified `Motor6D`.
- `motor` - The target `Motor6D` to stop swaying.
### `SwayModule:Listen()`
Starts / resumes swaying for all sway instances under the current `SwayModule`
### `SwayModule:Disconnect()`  
Stops and disconnects all swaying happening. (`sway` instances aren't don't get released)

## Example Usage
```lua
local SwayModule = require(game.ReplicatedStorage.SwayModule)

local motor = script.Parent:FindFirstChildWhichIsA("Motor6D")
SwayModule:Create(motor, Vector3.new(1, 0.5, 1), 2)
SwayModule:Listen()

task.wait(10)

SwayModule:Release(motor)
SwayModule:Disconnect()
```
