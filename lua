-- LocalScript under ScreenGui

local eggToPets = {
	["Common Egg"] = {"Bunny", "Mouse", "Deer"},
	["Uncommon Egg"] = {"Fox", "Raccoon", "Goat"},
	["Bug Egg"] = {"Ladybug", "Beetle", "Dragonfly"},
	["Bee Egg"] = {"Honey Bee", "Worker Bee", "Queen Bee"},
	["Dino Egg"] = {"Triceratops", "Raptor", "T-Rex"},
	["Fantasy Egg"] = {"Fairy", "Unicorn", "Dragon"},
	["Mystic Egg"] = {"Phantom", "Spirit Deer", "Celestial Fox"},
}

local ESPEnabled = false
local desiredPet = ""
local lastESPLabels = {}

local player = game.Players.LocalPlayer
local gui = script.Parent

local randomizeButton = gui:WaitForChild("RandomizeButton")
local espToggle = gui:WaitForChild("ESPToggle")
local desiredInput = gui:WaitForChild("DesiredPetBox")

-- UI Feedback on Button Press
local function animateButton(button)
	button.BackgroundColor3 = Color3.fromRGB(180, 180, 180)
	wait(0.1)
	button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
end

-- Clear all old labels
local function clearLabels()
	for _, label in pairs(lastESPLabels) do
		if label and label.Parent then
			label:Destroy()
		end
	end
	lastESPLabels = {}
end

-- Create BillboardGui label above egg
local function createLabel(egg, petName)
	local billboard = Instance.new("BillboardGui")
	billboard.Name = "PetLabel"
	billboard.Size = UDim2.new(0, 100, 0, 40)
	billboard.Adornee = egg:FindFirstChild("Head") or egg:FindFirstChildWhichIsA("BasePart")
	billboard.StudsOffset = Vector3.new(0, 3, 0)
	billboard.AlwaysOnTop = true

	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, 0, 1, 0)
	label.BackgroundTransparency = 1
	label.Text = petName
	label.TextScaled = true
	label.TextStrokeTransparency = 0.7
	label.Font = Enum.Font.FredokaOne
	label.TextColor3 = petName == desiredPet and Color3.fromRGB(255, 100, 100) or Color3.fromRGB(255, 255, 255)
	label.Font = petName == desiredPet and Enum.Font.GothamBold or Enum.Font.Gotham

	billboard.Parent = egg
	label.Parent = billboard
	table.insert(lastESPLabels, billboard)
end

-- Randomize pets visually over eggs
local function randomizePets()
	clearLabels()
	animateButton(randomizeButton)

	wait(math.random(10, 15)) -- Delay to simulate logic processing

	for _, egg in pairs(workspace:GetDescendants()) do
		if egg:IsA("Model") and eggToPets[egg.Name] then
			local petList = eggToPets[egg.Name]
			local chosenPet = petList[math.random(1, #petList)]
			if ESPEnabled then
				createLabel(egg, chosenPet)
			end
		end
	end
end

-- ESP toggle logic
espToggle.MouseButton1Click:Connect(function()
	ESPEnabled = not ESPEnabled
	animateButton(espToggle)

	if not ESPEnabled then
		clearLabels()
	end
end)

-- Desired pet input
desiredInput.FocusLost:Connect(function(enterPressed)
	if enterPressed then
		desiredPet = desiredInput.Text
	end
end)

-- Randomize button logic
randomizeButton.MouseButton1Click:Connect(randomizePets)
