if not game:IsLoaded() then game.Loaded:Wait() end
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local cfg = _G.cfg
local bg, btn, act = Color3.fromRGB(20,45,70), Color3.fromRGB(45,85,115), Color3.fromRGB(80,150,190)

local pg = LocalPlayer:WaitForChild("PlayerGui")
if pg:FindFirstChild("AimGui") then pg.AimGui:Destroy() end
local gui = Instance.new("ScreenGui", pg)
gui.Name = "AimGui"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true

local menu = Instance.new("Frame", gui)
menu.Size = UDim2.new(0, 380, 0, 320)
menu.Position = UDim2.new(0, 20, 0, 60)
menu.BackgroundColor3 = bg
Instance.new("UICorner", menu).CornerRadius = UDim.new(0, 14)
local ms = Instance.new("UIStroke", menu)
ms.Thickness = 2

local title = Instance.new("TextLabel", menu)
title.Size = UDim2.new(1, -40, 0, 35)
title.BackgroundTransparency = 1
title.Text = "Aim Menu"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold
title.TextSize = 16

local close = Instance.new("TextButton", menu)
close.Size = UDim2.new(0, 30, 0, 30)
close.Position = UDim2.new(0, 5, 0, 2)
close.BackgroundTransparency = 1
close.Text = "X"
close.TextColor3 = Color3.fromRGB(255, 80, 80)
close.Font = Enum.Font.GothamBold
close.TextSize = 18

local open = Instance.new("TextButton", gui)
open.Size = UDim2.new(0, 45, 0, 45)
open.Position = UDim2.new(0, 20, 0, 60)
open.BackgroundColor3 = bg
open.Text = "A"
open.TextColor3 = Color3.new(1,1,1)
open.Font = Enum.Font.GothamBold
open.TextSize = 20
Instance.new("UICorner", open).CornerRadius = UDim.new(1,0)
local os = Instance.new("UIStroke", open)
os.Thickness = 2
open.Visible = false

close.MouseButton1Click:Connect(function() menu.Visible = false; open.Visible = true end)
open.MouseButton1Click:Connect(function() menu.Visible = true; open.Visible = false end)

local contentFrame = Instance.new("Frame", menu)
contentFrame.Size = UDim2.new(1, 0, 1, -80)
contentFrame.Position = UDim2.new(0, 0, 0, 80)
contentFrame.BackgroundTransparency = 1

local function clearContent()
    for _, child in ipairs(contentFrame:GetChildren()) do
        if child:IsA("Frame") or child:IsA("TextButton") or child:IsA("TextLabel") or child:IsA("TextBox") then
            child:Destroy()
        end
    end
end

local navFrame = Instance.new("Frame", menu)
navFrame.Size = UDim2.new(1, 0, 0, 50)
navFrame.Position = UDim2.new(0, 0, 0, 30)
navFrame.BackgroundTransparency = 1

local function mkNav(txt, x, callback)
    local b = Instance.new("TextButton", navFrame)
    b.Size = UDim2.new(0, 50, 0, 50)
    b.Position = UDim2.new(0, x, 0, 0)
    b.BackgroundColor3 = btn
    b.Text = txt
    b.TextColor3 = Color3.new(1,1,1)
    b.Font = Enum.Font.Gotham
    b.TextSize = 24
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8)
    b.MouseButton1Click:Connect(callback)
    return b
end

-- Вкладки
local navCombat, navEsp, navBinds, navSet

local function loadCombatPage()
    clearContent()
    navCombat.BackgroundColor3 = act
    -- ... (код Combat страницы, как в предыдущем сообщении)
end

local function loadEspPage()
    clearContent()
    navEsp.BackgroundColor3 = act
    -- ... (код ESP страницы)
end

local function loadBindsPage()
    clearContent()
    navBinds.BackgroundColor3 = act
    -- ... (код вкладки Бинды)
end

local function loadSettingsPage()
    clearContent()
    navSet.BackgroundColor3 = act
    -- ... (код Настроек)
end

navCombat = mkNav("👊", 10, loadCombatPage)
navEsp = mkNav("👁️", 70, loadEspPage)
navBinds = mkNav("📌", 130, loadBindsPage)
navSet = mkNav("⚙️", 190, loadSettingsPage)

loadCombatPage()

-- Подсветка
local pal = {Color3.fromRGB(0,200,255), Color3.fromRGB(0,100,255), Color3.fromRGB(0,50,150), Color3.fromRGB(0,150,255), Color3.fromRGB(20,80,200)}
local ci, ct = 1, 0
RunService.RenderStepped:Connect(function(dt)
    local ni = ci % #pal + 1
    ct = ct + dt * 0.8
    if ct >= 1 then ct = 0; ci = ni end
    local fc = pal[ci]:Lerp(pal[ni], ct)
    ms.Color = fc; os.Color = fc
end)
