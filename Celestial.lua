local RayfieldSuccess, Rayfield = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/SiriusSoftwareLtd/Rayfield/main/source.lua"))()
end)

if not RayfieldSuccess then
    warn("No se pudo cargar Rayfield. Asegúrate de que la URL es correcta.")
    return
end

-- Estado para los toggles
local AutoFarmEnabled = false
local ESPEnabled = false

local Window = Rayfield:CreateWindow({
    Name = "🌌 Celestial",
    LoadingTitle = "Celestial On Top 🌠",
    LoadingSubtitle = "sxbxs.19 and andresitoulol",
    ConfigurationSaving = {
        Enabled = false,
        FolderName = nil,
        FileName = "Celestial"
    }
})

-- Tabs
local MainTab = Window:CreateTab("Main Functions✨", nil)
MainTab:CreateSection("Vesteria Game Functions")
local CreditsTab = Window:CreateTab("Credits 👑", nil)

-- AutoFarm Script
local function startAutoFarm()
    local monsterList = { 
        "Aevrul", "Baby Scarab", "Baby Shroom", "Baby Slime", "Baby Yeti", "Baby Yeti Tribute",
        "Bamboo Mage", "Bandit", "Bandit Skirmisher", "Battering Shroom", "Batty", "Bear",
        "Big Slime", "Birthday Mage", "Boar", "Book", "Bushi", "Chad", "Chicken", "Crabby",
        "Crow", "Cultist", "Dark Cleric", "Deathsting", "Dragon Boss", "Dragon Monk", "Dummy",
        "Dustwurm", "Eldering Shroom", "Elder Shroom", "Enchanted Slime", "Enchiridion",
        "Ent Sapling", "Ethera", "Ethereal Monarch", "Frightcrow", "Fish", "First Mate",
        "Fly Trap", "Gauntlet Gate", "Gecko", "Goblin", "Gorgog Guardian", "Guardian",
        "Guardian Dummy", "Hag", "Hermit Crabby", "Hitbox", "Hog", "Horseshoe Crab", "Humanoid",
        "Jellyfish", "Kobra", "Lil Shroomie Cage", "Lobster", "Lost Spirit", "Mama Hermit Crabby",
        "Master Miyamoto", "Mimic Jester", "Miner Prisoner", "Mo Ko Tu Aa", "Mogloko", "Moglo",
        "Monster", "Mosquito Parasite", "Mummy", "Orc", "Parasite", "Parasite Host",
        "Pirate", "Pirate Captain", "Pirate Summon", "Pit Ratty", "Possum the Devourer",
        "Prisoner", "Ram", "Ratty", "Reanimated Slime", "Reaper", "Redwood Bandit",
        "Redwood Bandit Leader", "Rock Slime", "Rootbeard", "Rubee", "Runic Titan",
        "Samurai", "Scarab", "Scarecrow", "Sensei", "Shade", "Shaman", "Shinobi", "Shroom",
        "Skeleton", "Skull Boss", "Slime", "Snel", "Soulcage", "Spider", "Spider Queen",
        "Spiderling", "Stingtail", "Sunken Savage", "Terror of the Deep", "The Yeti",
        "Toni", "Tortoise", "Treemuk", "Tribute Gate", "Trickster Spirit", "Tumbleweed",
        "Undead", "Wisp"
    }

    local folder = workspace.placeFolders.entityManifestCollection
    local newSize = Vector3.new(1000, 1000, 1000)

    local function shouldModify(part)
        return monsterList[part.Name] ~= nil
    end

    local function processParts()
        for _, part in pairs(folder:GetDescendants()) do
            if part:IsA("BasePart") and shouldModify(part) then
                if part.Size ~= newSize then 
                    part.Size = newSize
                end
                part.CanCollide = false 
            end
        end
    end

    processParts()

    folder.DescendantAdded:Connect(function(descendant)
        if AutoFarmEnabled and descendant:IsA("BasePart") and shouldModify(descendant) then
            if descendant.Size ~= newSize then
                descendant.Size = newSize
            end
            descendant.CanCollide = false
        end
    end)
end

local function stopAutoFarm()
    -- Detener AutoFarm al desactivar el toggle
    AutoFarmEnabled = false
    -- Aquí puedes añadir cualquier lógica para detener el AutoFarm si es necesario
end

-- ESP Script
local function startESP()
    local nombresValidos = {
        "Aevrul", "Baby Scarab", "Baby Shroom", "Baby Slime", "Baby Yeti", "Baby Yeti Tribute",
        "Bamboo Mage", "Bandit", "Bandit Skirmisher", "Battering Shroom", "Batty", "Bear",
        "Big Slime", "Birthday Mage", "Boar", "Book", "Bushi", "Chad", "Chicken", "Crabby",
        "Crow", "Cultist", "Dark Cleric", "Deathsting", "Dragon Boss", "Dragon Monk", "Dummy",
        "Dustwurm", "Eldering Shroom", "Elder Shroom", "Enchanted Slime", "Enchiridion",
        "Ent Sapling", "Ethera", "Ethereal Monarch", "Frightcrow", "Fish", "First Mate",
        "Fly Trap", "Gauntlet Gate", "Gecko", "Goblin", "Gorgog Guardian", "Guardian",
        "Guardian Dummy", "Hag", "Hermit Crabby", "Hitbox", "Hog", "Horseshoe Crab", "Humanoid",
        "Jellyfish", "Kobra", "Lil Shroomie Cage", "Lobster", "Lost Spirit", "Mama Hermit Crabby",
        "Master Miyamoto", "Mimic Jester", "Miner Prisoner", "Mo Ko Tu Aa", "Mogloko", "Moglo",
        "Monster", "Mosquito Parasite", "Mummy", "Orc", "Parasite", "Parasite Host",
        "Pirate", "Pirate Captain", "Pirate Summon", "Pit Ratty", "Possum the Devourer",
        "Prisoner", "Ram", "Ratty", "Reanimated Slime", "Reaper", "Redwood Bandit",
        "Redwood Bandit Leader", "Rock Slime", "Rootbeard", "Rubee", "Runic Titan",
        "Samurai", "Scarab", "Scarecrow", "Sensei", "Shade", "Shaman", "Shinobi", "Shroom",
        "Skeleton", "Skull Boss", "Slime", "Snel", "Soulcage", "Spider", "Spider Queen",
        "Spiderling", "Stingtail", "Sunken Savage", "Terror of the Deep", "The Yeti",
        "Toni", "Tortoise", "Treemuk", "Tribute Gate", "Trickster Spirit", "Tumbleweed",
        "Undead", "Wisp"
    }

    local folder = workspace:WaitForChild("placeFolders"):WaitForChild("entityManifestCollection")

    local function crearNombreLabel(part)
        if not ESPEnabled then return end
        if not part:IsA("BasePart") then return end
        if not nombresValidos[part.Name] then return end
        if part:FindFirstChild("ESP_NameTag") then return end

        local billboard = Instance.new("BillboardGui")
        billboard.Name = "ESP_NameTag"
        billboard.Size = UDim2.new(0, 200, 0, 50)
        billboard.StudsOffset = Vector3.new(0, 3, 0)
        billboard.AlwaysOnTop = true
        billboard.Parent = part

        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, 0, 1, 0)
        label.BackgroundTransparency = 1
        label.Text = part.Name
        label.TextColor3 = Color3.fromRGB(255, 0, 0)
        label.TextStrokeTransparency = 0.3
        label.TextScaled = true
        label.Font = Enum.Font.GothamBold
        label.Parent = billboard
    end

    for _, obj in ipairs(folder:GetDescendants()) do
        crearNombreLabel(obj)
    end

    folder.DescendantAdded:Connect(crearNombreLabel)
end

local function stopESP()
    -- Detener ESP al desactivar el toggle
    ESPEnabled = false
    -- Aquí puedes añadir cualquier lógica para detener el ESP si es necesario
end

-- 🔘 Toggles
MainTab:CreateToggle({
    Name = "Auto Farm Mobs",
    CurrentValue = false,
    Flag = "AutoFarmToggle",
    Callback = function(Value)
        AutoFarmEnabled = Value
        if AutoFarmEnabled then
            startAutoFarm()
        else
            stopAutoFarm() -- Detener el AutoFarm cuando esté en "off"
        end
    end,
})

MainTab:CreateToggle({
    Name = "ESP Mobs",
    CurrentValue = false,
    Flag = "EspMobsToggle",
    Callback = function(Value)
        ESPEnabled = Value
        if ESPEnabled then
            startESP()
        else
            stopESP() -- Detener el ESP cuando esté en "off"
        end
    end,
})

-- 📌 Créditos
CreditsTab:CreateParagraph
