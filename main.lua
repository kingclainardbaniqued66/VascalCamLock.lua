-- Glockz-Style CamLock (Fixed) by @kingclainardbaniqued66
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")
local LP = Players.LocalPlayer
local Mouse = LP:GetMouse()
local Camera = workspace.CurrentCamera

local CamLockEnabled = false
local Target = nil
local LockKey = Enum.KeyCode.RightShift

-- UI
local gui = Instance.new("ScreenGui", LP:WaitForChild("PlayerGui"))
gui.Name = "CamLockUI"
gui.ResetOnSpawn = false

local button = Instance.new("TextButton", gui)
button.Size = UDim2.new(0, 140, 0, 40)
button.Position = UDim2.new(0, 20, 0, 100)
button.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
button.TextColor3 = Color3.new(1, 1, 1)
button.Font = Enum.Font.SourceSansBold
button.TextSize = 16
button.Text = "CamLock (OFF)"
button.Draggable = true
button.Active = true

-- Toggle
local function ToggleCamLock()
	CamLockEnabled = not CamLockEnabled
	if CamLockEnabled then
		Target = nil -- Reset to pick new one
		button.Text = "CamLock (ON)"
	else
		Target = nil
		button.Text = "CamLock (OFF)"
	end
end

-- Input
button.MouseButton1Click:Connect(ToggleCamLock)
UIS.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	if input.KeyCode == LockKey then
		ToggleCamLock()
	end
end)

-- Find closest player to mouse
local function GetClosestPlayer()
	local closest, shortest = nil, math.huge
	for _, plr in pairs(Players:GetPlayers()) do
		if plr ~= LP and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
			local pos, visible = Camera:WorldToViewportPoint(plr.Character.HumanoidRootPart.Position)
			if visible then
				local dist = (Vector2.new(pos.X, pos.Y) - UIS:GetMouseLocation()).Magnitude
				if dist < shortest then
					shortest = dist
					closest = plr
				end
			end
		end
	end
	return closest
end

-- Lock-on
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
