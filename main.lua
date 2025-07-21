-- Vascal-Style CamLock by @yourname
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")
local LP = Players.LocalPlayer
local Mouse = LP:GetMouse()
local Camera = workspace.CurrentCamera

local CamLockEnabled = false
local Target = nil
local LockKey = Enum.KeyCode.RightShift

-- Create UI
local gui = Instance.new("ScreenGui", LP:WaitForChild("PlayerGui"))
gui.Name = "CamLockUI"

local button = Instance.new("TextButton", gui)
button.Size = UDim2.new(0, 120, 0, 40)
button.Position = UDim2.new(0, 15, 0, 100)
button.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
button.Text = "CamLock (OFF)"
button.TextColor3 = Color3.new(1,1,1)
button.TextSize = 16
button.Font = Enum.Font.SourceSansBold
button.Active = true
button.Draggable = true

-- Toggle function
local function ToggleCamLock()
	CamLockEnabled = not CamLockEnabled
	if not CamLockEnabled then
		Target = nil
	end
	button.Text = CamLockEnabled and "CamLock (ON)" or "CamLock (OFF)"
end

-- Input toggles
button.MouseButton1Click:Connect(ToggleCamLock)
UIS.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	if input.KeyCode == LockKey then
		ToggleCamLock()
	end
end)

-- Find closest player
local function GetClosestPlayer()
	local closest, dist = nil, math.huge
	for _, v in pairs(Players:GetPlayers()) do
		if v ~= LP and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
			local pos, visible = Camera:WorldToViewportPoint(v.Character.HumanoidRootPart.Position)
			if visible then
				local mag = (Vector2.new(pos.X, pos.Y) - UIS:GetMouseLocation()).Magnitude
				if mag < dist then
					closest = v
					dist = mag
				end
			end
-- Vascal-Style CamLock by @kingclainardbaniqued66
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")
local LP = Players.LocalPlayer
local Mouse = LP:GetMouse()
local Camera = workspace.CurrentCamera

local CamLockEnabled = false
local Target = nil
local LockKey = Enum.KeyCode.RightShift

-- Create UI
local gui = Instance.new("ScreenGui", LP:WaitForChild("PlayerGui"))
gui.Name = "CamLockUI"
gui.ResetOnSpawn = false

local button = Instance.new("TextButton", gui)
button.Size = UDim2.new(0, 130, 0, 40)
button.Position = UDim2.new(0, 15, 0, 100)
button.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
button.Text = "CamLock (OFF)"
button.TextColor3 = Color3.new(1, 1, 1)
button.TextSize = 16
button.Font = Enum.Font.SourceSansBold
button.Active = true
button.Draggable = true

-- Toggle function
local function ToggleCamLock()
	CamLockEnabled = not CamLockEnabled
	if not CamLockEnabled then
		Target = nil
	end
	button.Text = CamLockEnabled and "CamLock (ON)" or "CamLock (OFF)"
end

-- Button & keybind toggle
button.MouseButton1Click:Connect(ToggleCamLock)
UIS.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	if input.KeyCode == LockKey then
		ToggleCamLock()
	end
end)

-- Find closest player only ONCE when you lock
local function GetClosestPlayer()
	local closest, dist = nil, math.huge
	for _, v in pairs(Players:GetPlayers()) do
		if v ~= LP and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
			local pos, visible = Camera:WorldToViewportPoint(v.Character.HumanoidRootPart.Position)
			if visible then
				local mag = (Vector2.new(pos.X, pos.Y) - UIS:GetMouseLocation()).Magnitude
				if mag < dist then
					closest = v
					dist = mag
				end
			end
		end
	end
	return closest
end

-- Lock-on logic
RS.RenderStepped:Connect(function()
	if CamLockEnabled then
		if not Target then
			Target = GetClosestPlayer()
		end

		if Target and Target.Character and Target.Character:FindFirstChild("HumanoidRootPart") then
			Camera.CFrame = CFrame.new(Camera.CFrame.Position, Target.Character.HumanoidRootPart.Position)
		end
	end
end)
tance.new("TextButton")
ToggleButton.Size = UDim2.new(0, 130, 0, 40)
ToggleButton.Position = UDim2.new(0, 15, 0, 100)
ToggleButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
ToggleButton.Text = "CamLock (OFF)"
ToggleButton.TextColor3 = Color3.new(1,1,1)
ToggleButton.TextSize = 16
ToggleButton.Font = Enum.Font.SourceSansBold
ToggleButton.Parent = ScreenGui
ToggleButton.Active = true
ToggleButton.Draggable = true

-- Get Closest Player to Mouse
local function GetClosestPlayer()
rame = CFrame.new(Camera.CFrame.Position, Target.Character.Head.Position)
	end
end)
