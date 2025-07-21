-- VascalCamLock (Roblox Aimbot Script)
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera

local Settings = {
    AimPart = "Head",
    CamLockEnabled = true,
    AimSmoothness = 0.2
}

local Target = nil

function GetClosestPlayer()
    local closest = nil
    local shortestDistance = math.huge
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild(Settings.AimPart) then
            local pos = Camera:WorldToViewportPoint(player.Character[Settings.AimPart].Position)
            local dist = (Vector2.new(pos.X, pos.Y) - Vector2.new(Mouse.X, Mouse.Y)).Magnitude
            if dist < shortestDistance then
                shortestDistance = dist
                closest = player
            end
        end
    end
    return closest
end

RunService.RenderStepped:Connect(function()
    if Settings.CamLockEnabled then
        Target = GetClosestPlayer()
        if Target and Target.Character and Target.Character:FindFirstChild(Settings.AimPart) then
            local partPos = Target.Character[Settings.AimPart].Position
            Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, partPos), Settings.AimSmoothness)
        end
    end
end)

print("VascalCamLock loaded")
