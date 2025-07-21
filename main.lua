-- VascalCamLock with Draggable Toggle UI (Mobile + PC)

local Players = game:GetService("Players")
local Camera = workspace.CurrentCamera
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

local Settings = {
	CamLock = true,
	AimPart = "Head",
	Smoothness = 0.2,
	ToggleKey = Enum.KeyCode.RightShift
}

-- UI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "VascalUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game:GetService("CoreGui")

local Button = Instance.new("TextButton")
Button.Size = UDim2.new(0, 120, 0, 40)
Button.Position = UDim2.new(0.5, -60, 0, 20)
Button.Text = "CamLock: ON"
Button.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Button.TextColor3 = Color3.fromRGB(255, 255, 255)
Button.Font = Enum.Font.SourceSansBold
Button.TextSize = 20
Button.Parent = ScreenGui
Button.Active = true
Button.Draggable = true -- make it draggable

-- Toggle logic
Button.MouseButton1Click:Connect(function()
	Settings.CamLock = not Settings.CamLock
	Button.Text = "CamLock: " .. (Settings.CamLock and "ON" or "OFF")
end)

-- Keyboard toggle
UserInputService.InputBegan:Connect(function(input, gpe)
	if gpe then return end
	if input.KeyCode == Settings.ToggleKey then
		Settings.CamLock = not Settings.CamLock
		Button.Text = "CamLock: " .. (Settings.CamLock and "ON" or "OFF")
	end
end)

-- Get closest player to cursor
local function GetClosestPlayer()
	local closest, distance = nil, math.huge
	for _, player in ipairs(Players:GetPlayers()) do
		if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild(Settings.AimPart) then
			local screenPoint, onScreen = Camera:WorldToViewportPoint(player.Character[Settings.AimPart].Position)
			if onScreen then
				local dist = (Vector2.new(Mouse.X, Mouse.Y) - Vector2.new(screenPoint.X, screenPoint.Y)).Magnitude
				if dist < distance then
					closest = player
					distance = dist
				end
			end
		end
	end
	return closest
end

-- Main CamLock loop
RunService.RenderStepped:Connect(function()
	if Settings.CamLock then
		local target = GetClosestPlayer()
		if target and target.Character and target.Character:FindFirstChild(Settings.AimPart) then
			local aimPos = target.Character[Settings.AimPart].Position
			local current = Camera.CFrame.Position
			local newCFrame = CFrame.new(current, current:Lerp(aimPos, Settings.Smoothness))
			Camera.CFrame = newCFrame
		end
	end
end)
