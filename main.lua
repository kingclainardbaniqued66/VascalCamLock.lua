-- VascalCamLock Script
local Players = game:GetService("Players")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

local Settings = {
    CamLock = true,
    AimPart = "Head",
    Smoothness = 0.2
}

local function GetClosest()
    local closest, shortest = nil, math.huge
    for _, v in pairs(Players:GetPlayers()) do
        if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild(Settings.AimPart) then
            local pos = Camera:WorldToViewportPoint(v.Character[Settings.AimPart].Position)
            local dist = (Vector2.new(pos.X, pos.Y) - Vector2.new(Mouse.X, Mouse.Y)).Magnitude
            if dist < shortest then
                shortest = dist
                closest = v
            end
        end
    end
    return closest
end

game:GetService("RunService").RenderStepped:Connect(function()
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

print("VascalCamLock loaded")
