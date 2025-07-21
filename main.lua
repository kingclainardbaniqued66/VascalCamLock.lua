-- Vascal-Style CamLock by @kingclainardbaniqued66
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LP = Players.LocalPlayer
local Mouse = LP:GetMouse()
local Camera = workspace.CurrentCamera

local CamLockEnabled = false
local Target = nil
local LockKey = Enum.KeyCode.RightShift

-- UI Setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CamLockUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = LP:WaitForChild("PlayerGui")

local ToggleButton = Instance.new("TextButton")
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
	local maxDist = math.huge
	local closest = nil

	for _, player in pairs(Players:GetPlayers()) do
		if player ~= LP and player.Character and player.Character:FindFirstChild("Head") then
			local pos, onScreen = Camera:WorldToViewportPoint(player.Character.Head.Position)
			if onScreen then
				local dist = (Vector2.new(pos.X, pos.Y) - Vector2.new(Mouse.X, Mouse.Y)).Magnitude
				if dist < maxDist then
					maxDist = dist
					closest = player
				end
			end
		end
	end

	return closest
end

-- Lock/Unlock Cam
local function ToggleCamLock()
	CamLockEnabled = not CamLockEnabled

	if CamLockEnabled then
		Target = GetClosestPlayer()
		ToggleButton.Text = "CamLock (ON)"
	else
		Target = nil
		ToggleButton.Text = "CamLock (OFF)"
	end
end

-- Input Toggle
UIS.InputBegan:Connect(function(input, gpe)
	if gpe then return end
	if input.KeyCode == LockKey then
		ToggleCamLock()
	end
end)

-- Button Toggle
ToggleButton.MouseButton1Click:Connect(function()
	ToggleCamLock()
end)

-- Lock Logic
RunService.RenderStepped:Connect(function()
	if CamLockEnabled and Target and Target.Character and Target.Character:FindFirstChild("Head") then
		Camera.CFrame = CFrame.new(Camera.CFrame.Position, Target.Character.Head.Position)
	end
end)
