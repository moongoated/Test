--[[ 
    Fluent Dark Monaco Patch
    Synapse X / KRNL style
    Background Image Applied
    Image ID: 104535323405239
]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")

-- === LOAD ORIGINAL LIBRARY ===
local Library, SaveManager, InterfaceManager, Mobile =
    loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/main/main.lua"))()

-- === FORCE DARK MONACO THEME ===
Library.Themes.DarkMonaco = {
    Name = "Dark Monaco",

    Accent = Color3.fromRGB(100, 120, 255),
    Outline = Color3.fromRGB(40, 40, 40),

    Background = Color3.fromRGB(18, 18, 18),
    LightBackground = Color3.fromRGB(26, 26, 26),
    DarkBackground = Color3.fromRGB(14, 14, 14),

    TextColor = Color3.fromRGB(230, 230, 230),
    DisabledTextColor = Color3.fromRGB(120, 120, 120),

    BorderColor = Color3.fromRGB(50, 50, 50)
}

Library:SetTheme("DarkMonaco")

-- === CREATE WINDOW ===
local Window = Library:CreateWindow({
    Title = "Fluent",
    SubTitle = "Dark Monaco",
    TabWidth = 160,
    Size = UDim2.fromOffset(560, 460),
    Acrylic = false,
    Theme = "DarkMonaco",
    MinimizeKey = Enum.KeyCode.LeftControl
})

-- === BACKGROUND IMAGE LAYER (SYNAPSE / KRNL STYLE) ===
task.spawn(function()
    task.wait(0.2)

    local ScreenGui = PlayerGui:FindFirstChild("Fluent")
    if not ScreenGui then return end

    local Main = ScreenGui:FindFirstChild("Main", true)
    if not Main then return end

    local Image = Instance.new("ImageLabel")
    Image.Name = "BackgroundImage"
    Image.Parent = Main
    Image.Image = "rbxassetid://104535323405239"
    Image.BackgroundTransparency = 1
    Image.Size = UDim2.fromScale(1, 1)
    Image.Position = UDim2.fromScale(0, 0)
    Image.ZIndex = 0
    Image.ImageTransparency = 0.88
    Image.ScaleType = Enum.ScaleType.Crop

    -- Dark overlay for readability
    local Overlay = Instance.new("Frame")
    Overlay.Parent = Image
    Overlay.Size = UDim2.fromScale(1, 1)
    Overlay.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
    Overlay.BackgroundTransparency = 0.35
    Overlay.ZIndex = 1
end)

-- === EXAMPLE TAB ===
local Tab = Window:AddTab({ Title = "Main", Icon = "home" })

Tab:AddParagraph({
    Title = "Dark Monaco UI",
    Content = "Synapse X / KRNL inspired theme\nBackground image applied"
})

Tab:AddButton({
    Title = "Test Notification",
    Callback = function()
        Library:Notify({
            Title = "Dark Mode",
            Content = "Theme applied successfully",
            Duration = 5
        })
    end
})

-- === SAVE / INTERFACE MANAGERS ===
SaveManager:SetLibrary(Library)
InterfaceManager:SetLibrary(Library)

SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({})

InterfaceManager:SetFolder("FluentScript")
SaveManager:SetFolder("FluentScript/configs")

InterfaceManager:BuildInterfaceSection(Tab)
SaveManager:BuildConfigSection(Tab)

-- === STUDIO FIX ===
if RunService:IsStudio() then
    task.wait(0.05)
end

return Library, SaveManager, InterfaceManager, Mobile
