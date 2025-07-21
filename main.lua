-- VascalCamLock (Toggle + CamLock)

local Players = game:GetService("Players")
local Camera = workspace.CurrentCamera
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

local Settings = {
    CamLock = true,
    AimPart = "Head", -- You can change to "HumanoidRootPart" if you want
    Smoothness = 0.2,
    ToggleKey = Enum.KeyCode.RightShift
}

local function GetClosest()
    local closest, shortest = nil, math.huge
    for _, v in pairs(Players:GetPlayers()) do
        if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild(Settings.AimPart) then
            local pos, visible = Camera:WorldToViewportPoint(v.Character[Settings.AimPart].Position)
            if visible then
                local dist = (Vector2.new(Mouse.X, Mouse.Y) - Vector2.new(pos.X, pos.Y)).Magnitude
                if dist < shortest then
                    shortest = dist
                    closest = v
                end
            end
        end
    end
    return closest
end

-- CamLock loop
RunService.RenderStepped:Connect(function()
    if Settings.CamLock then
        local target = GetClosest()
        if target and target.Character and target.Character:FindFirstChild(Settings.AimPart) then
            Camera.CFrame = Camera.CFrame:Lerp(
                CFrame.new(Camera.CFrame.Position, target.Character[Settings.AimPart].Position),
                Settings.Smoothness
            )
        end
    end
end)

-- Toggle with RightShift
UserInputService.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode == Settings.ToggleKey then
        Settings.CamLock = not Settings.CamLock
        print("CamLock is now", Settings.CamLock and "ON" or "   end
end)

print("VascalCamLock loaded")
