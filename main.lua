local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local CamLockEnabled = false
local LockedTarget = nil
local AimPart = "Head"

-- Function to get closest player in view
local function GetClosestPlayer()
	local closest, distance = nil, math.huge
	for _, player in pairs(Players:GetPlayers()) do
		if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild(AimPart) then
			local screenPos, onScreen = Camera:WorldToViewportPoint(player.Character[AimPart].Position)
			if onScreen then
				local diff = (Vector2.new(screenPos.X, screenPos.Y) - UserInputService:GetMouseLocation()).Magnitude
				if diff < distance then
					distance = diff
					closest = player
				end
			end
		end
	end
	return closest
end

-- Lock on RightShift
UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if input.KeyCode == Enum.KeyCode.RightShift and not gameProcessed then
		CamLockEnabled = not CamLockEnabled

		if CamLockEnabled then
			LockedTarget = GetClosestPlayer()
		else
			LockedTarget = nil
		end
	end
end)

-- Cam lock loop
RunService.RenderStepped:Connect(function()
	if CamLockEnabled and LockedTarget and LockedTarget.Character and LockedTarget.Character:FindFirstChild(AimPart) then
		Camera.CFrame = CFrame.new(Camera.CFrame.Position, LockedTarget.Character[AimPart].Position)
	end
end)

-- Draggable Toggle Button UI
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local Button = Instance.new("TextButton", ScreenGui)
Button.Size = UDim2.new(0, 120, 0, 40)
Button.Position = UDim2.new(0.5, -60, 0, 100)
Button.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Button.TextColor3 = Color3.new(1, 1, 1)
Button.Text = "CamLock: OFF"
Button.Draggable = true
Button.Active = true

Button.MouseButton1Click:Connect(function()
	CamLockEnabled = not CamLockEnabled
	if CamLockEnabled then
		LockedTarget = GetClosestPlayer()
		Button.Text = "CamLock: ON"
	else
		LockedTarget = nil
		Button.Text = "CamLock: OFF"
	end
end)-- VascalCamLock with Draggable Toggle UI (Mobile + PC)

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
int.Y)).Magnitude
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
