-- KenScripts: Visual Egg Randomizer GUI with Desired Pet Alert + Draggable UI
-- Fully accurate as of July 2025 - Based on Grow a Garden Wiki

local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local player = Players.LocalPlayer
local mouse = player:GetMouse()

local petMapping = {
    ["Common Egg"] = {
        "Bunny", "Chicken", "Duck", "Pig", "Sheep",
        "Mouse", "Goat", "Deer", "Fox"
    },
    ["Bug Egg"] = {
        "Beetle", "Ladybug", "Caterpillar", "Dragonfly", "Grasshopper"
    },
    ["Bee Egg"] = {
        "Worker Bee", "Bumblebee", "Honey Bee", "Queen Bee"
    },
    ["Dino Egg"] = {
        "T-Rex", "Triceratops", "Stegosaurus", "Velociraptor", "Pterodactyl"
    },
    ["Fantasy Egg"] = {
        "Dragon", "Phoenix", "Fairy", "Griffin"
    },
    ["Mystic Egg"] = {
        "Phantom", "Spirit Deer", "Celestial Fox", "Nebula Cat", "Void Bat"
    },
    ["Aquatic Egg"] = {
        "Dolphin", "Jellyfish", "Sea Turtle", "Octopus", "Shark"
    },
    ["Farm Egg"] = {
        "Cow", "Lamb", "Horse", "Rooster", "Turkey"
    },
    ["Night Egg"] = {
        "Bat", "Ghost Cat", "Owl", "Shadow Fox", "Raccoon"
    }
}

local ScreenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
ScreenGui.Name = "KenRandomizerGUI"
ScreenGui.ResetOnSpawn = false

local Frame = Instance.new("Frame", ScreenGui)
Frame.Position = UDim2.new(0.1, 0, 0.1, 0)
Frame.Size = UDim2.new(0, 250, 0, 200)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true

local UICorner = Instance.new("UICorner", Frame)
UICorner.CornerRadius = UDim.new(0, 10)

local Title = Instance.new("TextLabel", Frame)
Title.Text = "KenScripts Randomizer"
Title.Size = UDim2.new(1, 0, 0, 30)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18

local InputBox = Instance.new("TextBox", Frame)
InputBox.PlaceholderText = "Enter Desired Pet"
InputBox.Size = UDim2.new(1, -20, 0, 30)
InputBox.Position = UDim2.new(0, 10, 0, 40)
InputBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
InputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
InputBox.Font = Enum.Font.Gotham
InputBox.TextSize = 14

local RandomizeButton = Instance.new("TextButton", Frame)
RandomizeButton.Text = "🎲 Randomize"
RandomizeButton.Size = UDim2.new(1, -20, 0, 30)
RandomizeButton.Position = UDim2.new(0, 10, 0, 80)
RandomizeButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
RandomizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
RandomizeButton.Font = Enum.Font.Gotham
RandomizeButton.TextSize = 16

local ESPToggle = Instance.new("TextButton", Frame)
ESPToggle.Text = "🔍 ESP: OFF"
ESPToggle.Size = UDim2.new(1, -20, 0, 30)
ESPToggle.Position = UDim2.new(0, 10, 0, 120)
ESPToggle.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
ESPToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
ESPToggle.Font = Enum.Font.Gotham
ESPToggle.TextSize = 16

local espEnabled = false
ESPToggle.MouseButton1Click:Connect(function()
    espEnabled = not espEnabled
    ESPToggle.Text = espEnabled and "🔍 ESP: ON" or "🔍 ESP: OFF"
end)

local function displayPetLabels()
    local desiredPet = InputBox.Text:lower()
    for _, egg in pairs(workspace:GetDescendants()) do
        if egg:IsA("Model") and petMapping[egg.Name] then
            local pets = petMapping[egg.Name]
            local randomPet = pets[math.random(1, #pets)]

            local existing = egg:FindFirstChild("KenPetLabel")
            if existing then existing:Destroy() end

            if espEnabled then
                local billboard = Instance.new("BillboardGui", egg)
                billboard.Name = "KenPetLabel"
                billboard.Adornee = egg:FindFirstChildWhichIsA("BasePart")
                billboard.Size = UDim2.new(0, 200, 0, 30)
                billboard.StudsOffset = Vector3.new(0, 3, 0)
                billboard.AlwaysOnTop = true

                local label = Instance.new("TextLabel", billboard)
                label.Size = UDim2.new(1, 0, 1, 0)
                label.BackgroundTransparency = 1
                label.Text = randomPet
                label.Font = Enum.Font.Gotham
                label.TextScaled = true

                if randomPet:lower() == desiredPet then
                    label.TextColor3 = Color3.fromRGB(255, 200, 0)
                    StarterGui:SetCore("SendNotification", {
                        Title = "🎉 Pet Found!",
                        Text = "Your desired pet '" .. randomPet .. "' has appeared!",
                        Duration = 4
                    })
                else
                    label.TextColor3 = Color3.fromRGB(255, 255, 255)
                end
            end
        end
    end
end

RandomizeButton.MouseButton1Click:Connect(displayPetLabels)
